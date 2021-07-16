//
//  GetListDataResource.swift
//  PayBayMaxChallenge
//
//  Created by Syed Asim Najam on 20/06/2021.
//

import Foundation
import Models

extension ServerResource {
    public static func getListData() -> ServerResource<List> {
        let urlRequest = URLRequest.create(urlPath: "list", requestMethod: .get, queryParams: [:])
        return ServerResource<List>(urlRequest: urlRequest, decode: List.decode)
    }
}
