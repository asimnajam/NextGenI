//
//  CurrencyExchangeListViewModel.swift
//  PayBayMaxChallenge
//
//  Created by Syed Asim Najam on 20/06/2021.
//

import Foundation
import Models

protocol CurrencyExchangeListViewModelProtocol {
    var state: CurrencyExchangeListViewModel.State { get set }
    var existingStateValues: (sourceCurrency: CurrencyProtocol?, customAmount: Double?)? { get }
    var currencies: [CurrencyProtocol] { get }
    var liveData: Live? { get set }
    
    func calculateExchangeRate(currency: CurrencyProtocol?) -> Double
    func fetch()
}

final class CurrencyExchangeListViewModel: CurrencyExchangeListViewModelProtocol {
    enum State {
        case empty
        case currenciesFetched(data: Live?)
        case customAmountEntered(sourceCurrency: CurrencyProtocol?, amount: Double)
        case sourceCurrencySelected(sourceCurrency: CurrencyProtocol, amount: Double?)
    }
    
    internal var state: State = .empty {
        didSet {
            onStateChange?(state)
        }
    }
    
    internal var liveData: Live? {
        didSet {
            onListFetched?(liveData)
        }
    }
    
    internal var existingStateValues: (sourceCurrency: CurrencyProtocol?, customAmount: Double?)? {
        switch state {
        case .currenciesFetched, .empty:
            return nil
        case let .customAmountEntered(sourceCurrency, customAmount):
            return (sourceCurrency, customAmount)
        case let .sourceCurrencySelected(sourceCurrency, customAmount):
            return (sourceCurrency, customAmount)
        }
    }
    
    internal var currencies: [CurrencyProtocol] {
        guard let liveData = liveData else { return [] }
        return liveData.currencies
    }
    
    var onStateChange: ((State) -> Void)?
    var onListFetched: OnDataFetched?
    
    var amountDidChanged: ((Double) -> Void)?
    var onCurrencySelection: ((Currency) -> Void)?
    private var timer: Timer?
    private let defaultAmount: Double = 1.0
    private let liveAPICommunicator: LiveAPICommunicator
    
    public var rowsCount: Int { currencies.count }
    
    init(liveAPICommunicator: LiveAPICommunicator) {
        self.liveAPICommunicator = liveAPICommunicator
        amountDidChanged = { [weak self] amount in
            guard let self = self else { return }
            self.state = .customAmountEntered(
                sourceCurrency: self.existingStateValues?.sourceCurrency,
                amount: amount
            )
        }
        
        onCurrencySelection = { [weak self] sourceCurrency in
            guard let self = self else { return }
            self.state = .sourceCurrencySelected(
                sourceCurrency: sourceCurrency,
                amount: self.existingStateValues?.customAmount
            )
        }
    }
    
    internal func calculateExchangeRate(currency: CurrencyProtocol?) -> Double {
        return currency?.calculateExchangeRate(sourceCurrency: existingStateValues?.sourceCurrency, customAmount: existingStateValues?.customAmount) ?? 1.0
    }
    
    internal func fetch() {
        if timer == nil {
            setTimer()
        }
        liveAPICommunicator.callLiveAPI(
            success: { [weak self] liveData in
                self?.state = .currenciesFetched(data: liveData)
                self?.liveData = liveData
            }, failure: { error in
                if let error = error {
                    print(error)
                }
            }
        )
    }
    
    func setTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 30, repeats: true) { [weak self] _ in
            self?.fetch()
        }
    }
    
    deinit {
        timer = nil
    }
}

extension CurrencyExchangeListViewModel {
    func cellViewModel(currency: CurrencyProtocol) -> CellViewModel {
        let calculatedCurrencyExchangeRate = calculateExchangeRate(currency: currency)
        return CellViewModel(
            currencyName: currency.code,
            exchangeRate: calculatedCurrencyExchangeRate
        )
    }
    
    func currency(at index: Int) -> CurrencyProtocol? {
        currencies.get(index)
    }
}
