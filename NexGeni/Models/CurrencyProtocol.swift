//
//  CurrencyProtocol.swift
//  Models
//
//  Created by Syed Asim Najam on 20/06/2021.
//

import Foundation

public protocol CurrencyProtocol {
    var code: String { get }
    var exchangeRate: Double { get }
    var name: String { get }
}

extension CurrencyProtocol {
    public func calculateExchangeRate(sourceCurrency: CurrencyProtocol?, customAmount: Double?) -> Double {
        let sourceCurrencyExRate: Double = sourceCurrency?.exchangeRate ?? 1.0
        let currentExchangeRate: Double = exchangeRate
        let amount = customAmount ?? 1.0
        let calculatedCurrencyExchangeRate: Double = (currentExchangeRate / (sourceCurrencyExRate)) * (amount)
        return calculatedCurrencyExchangeRate
    }
}
