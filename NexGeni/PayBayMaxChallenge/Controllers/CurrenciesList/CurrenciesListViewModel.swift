//
//  CurrenciesListViewModel.swift
//  PayBayMaxChallenge
//
//  Created by Syed Asim Najam on 20/06/2021.
//

import Foundation
import Models

typealias OnDataFetched = ((Codable) -> Void)

final class CurrenciesListViewModel {
    private let listAPICommunicator: ListAPICommunicator
    private let currenciesExchangeRates: [CurrencyProtocol]
    private (set) var listData: List? {
        didSet {
            onListFetched?(listData)
        }
    }
    
    var currencies: [CurrencyProtocol] {
        guard let listData = listData else { return [] }
        return listData.currencies.sorted(by: { $0.key < $1.key }).map { dict -> Currency in
            let exchangeRate: Double
            if let currency = currenciesExchangeRates.first(where: { $0.code == dict.key }) {
                exchangeRate = currency.exchangeRate
            } else {
                exchangeRate = 0.0
            }
            return Currency(exchangeRate: exchangeRate, code: dict.key, name: dict.value)
        }
    }
    
    var onCurrencySelection: ((Currency) -> Void)?
    var onListFetched: OnDataFetched?
    
    init(listAPICommunicator: ListAPICommunicator, currenciesExchangeRates: [CurrencyProtocol]) {
        self.currenciesExchangeRates = currenciesExchangeRates
        self.listAPICommunicator = listAPICommunicator
    }
    
    func fetch() {
        listAPICommunicator.callListAPI(success: { [weak self] listData in
            self?.listData = listData
        }, failure: { error in
            if let error = error {
                print(error)
            }
        })
    }
}
