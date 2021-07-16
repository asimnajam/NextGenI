//
//  ServerResponse.swift
//  PayBayMaxChallenge
//
//  Created by Syed Asim Najam on 20/06/2021.
//

import Foundation

public struct ServerResponse {
    let data: Data?
    let httpUrlResponse: HTTPURLResponse?
    let urlError: URLError?
}

extension ServerResponse {
    // extract custom error message here
    var errorMessage: String? {
        nil
    }
}
