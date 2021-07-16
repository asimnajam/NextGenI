//
//  GetListDataResource.swift
//  PayBayMaxChallenge
//
//  Created by Syed Asim Najam on 20/06/2021.
//

import Foundation
import Models

extension ServerResource {
    public static func getProducts(by categoryUrl: String) -> ServerResource<Products> {
        let parameters: [String: String] = ["category_url": categoryUrl]
        let urlRequest = URLRequest.create(urlPath: "get_products_from_category", requestMethod: .get, queryParams: parameters)
        return ServerResource<Products>(urlRequest: urlRequest, decode: Products.decode)
    }
}
