//
//  GetProductDetailResource.swift
//  Networking
//
//  Created by Syed Asim Najam on 24/06/2021.
//

import Foundation
import Models

extension ServerResource {
    public static func getProductDetail(by productUrl: String) -> ServerResource<ProductDetail> {
        let parameters: [String: String] = ["product_url": productUrl]
        let urlRequest = URLRequest.create(urlPath: "get_product", requestMethod: .get, queryParams: parameters)
        return ServerResource<ProductDetail>(urlRequest: urlRequest, decode: ProductDetail.decode)
    }
}
