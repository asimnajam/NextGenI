//
//  Live.swift
//  PayBayMaxChallenge
//
//  Created by Syed Asim Najam on 17/06/2021.
//

import Foundation

public struct Live: Codable {
    public let success: Bool
    public let terms: String
    public let privacy: String
    public let timestamp: Date
    public let source: String
    public let quotes: [String: Double]
    
    public init(success: Bool, terms: String, privacy: String, timestamp: Date, source: String, quotes: [String : Double]) {
        self.success = success
        self.terms = terms
        self.privacy = privacy
        self.timestamp = timestamp
        self.source = source
        self.quotes = quotes
    }
}

public extension Live {
    var currencies: [CurrencyProtocol] {
        return quotes.sorted(by: { $0.key < $1.key }).map { dict -> Currency in
            let code: String
            if dict.key == "USD" {
                code = dict.key
            } else {
                code = dict.key.replacingOccurrences(of: "USD", with: "")
            }
            return Currency(
                exchangeRate: dict.value,
                code: code,
                name: ""
            )
        }
    }
}
