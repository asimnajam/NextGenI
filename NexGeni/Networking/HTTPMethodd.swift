//
//  HTTPMethodd.swift
//  Networking
//
//  Created by Syed Asim Najam on 20/06/2021.
//

import Foundation

public enum HTTPMethodd {
    case get
    case put(params: Data)
    case patch(params: Data)
    case post(params: Data)
    case delete

    var stringValue: String {
        switch self {
        case .get:
            return "GET"
        case .put:
            return "PUT"
        case .patch:
            return "PATCH"
        case .post:
            return "POST"
        case .delete:
            return "DELETE"
        }
    }
}
