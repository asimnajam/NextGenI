//
//  ServerResource.swift
//  Networking
//
//  Created by Syed Asim Najam on 20/06/2021.
//

import Foundation

public struct ServerResource<ResponseModel> {
    let urlRequest: URLRequest
    let decode: (ServerResponse) -> ResponseModel?
    
    public init(urlRequest: URLRequest, decode: @escaping (ServerResponse) -> ResponseModel?) {
        self.urlRequest = urlRequest
        self.decode = decode
    }
}
