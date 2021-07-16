//
//  URLRequestExtension.swift
//  Networking
//
//  Created by Syed Asim Najam on 20/06/2021.
//

import Foundation

extension URLRequest {
    private static var baseURL: String = "https://gearbest.p.rapidapi.com/"
    
    static var defaultHeaders: [String: String] {
        [
            "x-rapidapi-host": "gearbest.p.rapidapi.com",
            "x-rapidapi-key": "59b1ee08a3msh99d7f50826d056dp1550d1jsnb931a3343a11"
        ]
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
            urlComponents.queryItems = queryParams?.map {
                URLQueryItem(
                    name: $0.key,
                    value: $0.value.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
                )
            }
            return urlComponents.url(relativeTo: URL(string: baseURL)!)!
        }()
        
        var request = URLRequest(url: url)
        request.httpMethod = requestMethod.stringValue
        
        for (headerField, value) in additionalHeaders {
            request.addValue(value, forHTTPHeaderField: headerField)
        }
        
        for (headerField, value) in defaultHeaders {
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
