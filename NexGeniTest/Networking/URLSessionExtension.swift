//
//  URLSessionExtension.swift
//  PayBayMaxChallenge
//
//  Created by Syed Asim Najam on 20/06/2021.
//

import Foundation

extension URLSession {
    public func performRequest<ResponseModel>(resource: ServerResource<ResponseModel>, success: @escaping ((ResponseModel) -> Void), failure: @escaping ((Error?) -> Void)) {
        let request = resource.urlRequest
        dataTask(with: request) { (data, response, error) in
            let serverResponse = ServerResponse(
                data: data,
                httpUrlResponse: response as? HTTPURLResponse,
                urlError: error as? URLError
            )
            if let decodedValue = resource.decode(serverResponse) {
                success(decodedValue)
            } else {
                failure(serverResponse.urlError)
            }
        }.resume()
    }
}
