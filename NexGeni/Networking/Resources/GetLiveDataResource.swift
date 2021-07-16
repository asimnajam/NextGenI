//
//  GetLiveDataResource.swift
//  PayBayMaxChallenge
//
//  Created by Syed Asim Najam on 20/06/2021.
//

import Foundation
import Models

extension ServerResource {
    public static func getLiveData() -> ServerResource<Live> {
        let urlRequest = URLRequest.create(urlPath: "live", requestMethod: .get, queryParams: [:])
        return ServerResource<Live>(urlRequest: urlRequest, decode: Live.decode)
    }
}
