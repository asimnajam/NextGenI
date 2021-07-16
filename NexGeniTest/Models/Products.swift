//
//  Products.swift
//  NexGeniTest
//
//  Created by Syed Asim Najam on 24/06/2021.
//

import Foundation

public struct Products: Codable {
    public let status: Int
    public let msg: String
    public let data: [ProductData]
}
