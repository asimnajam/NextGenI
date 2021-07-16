//
//  Currency.swift
//  Models
//
//  Created by Syed Asim Najam on 20/06/2021.
//

import Foundation

public struct Currency: CurrencyProtocol {
    public var exchangeRate: Double
    public let code: String
    public let name: String
    
    public init(exchangeRate: Double, code: String, name: String) {
        self.exchangeRate = exchangeRate
        self.code = code
        self.name = name
    }
    
//    public func calculateExchangeRate(sourceCurrency: CurrencyProtocol?, customAmount: Double?) -> Double {
//        let sourceCurrencyExRate: Double = sourceCurrency?.exchangeRate ?? 1.0
//        let currentExchangeRate: Double = exchangeRate
//        let amount = customAmount ?? 1.0
//        let calculatedCurrencyExchangeRate: Double = (currentExchangeRate / (sourceCurrencyExRate)) * (amount)
//        return calculatedCurrencyExchangeRate
//    }
}
