//
//  CurrencyList.swift
//  Models
//
//  Created by Syed Asim Najam on 20/06/2021.
//

import Foundation

public struct List: Codable {
    public let success: Bool
    public let terms: String
    public let privacy: String
    public let currencies: [String: String]
}
