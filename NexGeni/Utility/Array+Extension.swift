//
//  Array+Extension.swift
//  PayBayMaxChallenge
//
//  Created by Syed Asim Najam on 17/06/2021.
//

import Foundation
import Models

extension Array {
    public func get(_ index: Int) -> Element? {
        if index >= 0, index < count {
            return self[index]
        } else {
            return nil
        }
    }
}

extension Array where Element: CurrencyProtocol {
    func getCurrencies(liveData: Live) -> [CurrencyProtocol] {
        return liveData.quotes.sorted(by: { $0.key < $1.key }).map { dict -> Currency in
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
