//
//  URLRequestExtension.swift
//  Networking
//
//  Created by Syed Asim Najam on 20/06/2021.
//

import Foundation

extension URLRequest {
    private static var baseURL: String = "http://api.currencylayer.com/"
    
    static var defaultQueryParams: [String: String] {
        ["access_key": "20ca10ea1d5d9aabf7e6f0c328be6f7a"]
    }
}

extension URLRequest {
    public static func create(
        urlPath: String,
        requestMethod: HTTPMethodd,
        additionalHeaders: [String: String] = [:],
        queryParams: [String: String]? = nil
    ) -> Self {
        let url: URL = {
            var urlComponents = URLComponents(string: urlPath)!
            var query = defaultQueryParams
            if let additionalQueryParams = queryParams {
                query.merge(additionalQueryParams, uniquingKeysWith: { (current, _) in current })
            }
            urlComponents.queryItems = query.map { URLQueryItem(name: $0.key, value: $0.value.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)) }
            return urlComponents.url(relativeTo: URL(string: baseURL)!)!
        }()
        
        var request = URLRequest(url: url)
        request.httpMethod = requestMethod.stringValue
        
        for (headerField, value) in additionalHeaders {
            request.addValue(value, forHTTPHeaderField: headerField)
        }
        
        switch requestMethod {
        case .get, .delete:
            break
        case let .put(params), let .patch(params), let .post(params):
            request.httpBody = params
        }
        
        return request
    }
}
