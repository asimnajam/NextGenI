//
//  CurrencyExchangeListViewModelTests.swift
//  PayBayMaxChallengeTests
//
//  Created by Syed Asim Najam on 21/06/2021.
//

import XCTest
import Models

@testable import PayBayMaxChallenge

class CurrencyExchangeListViewModelTests: XCTestCase {
    private let defaultAmount: Double = 1.0
    
    func test_ViewModel_CurrencySelectedState() {
        let viewModel = MockViewModel()
        let sourceCurrency = MockCurrency.dirham
        let state: CurrencyExchangeListViewModel.State = .sourceCurrencySelected(sourceCurrency: sourceCurrency, amount: defaultAmount)
        viewModel.state = state
        XCTAssertEqual(viewModel.existingStateValues?.sourceCurrency?.exchangeRate, 3.673104)
        XCTAssertEqual(viewModel.existingStateValues?.sourceCurrency?.code, "AED")
        XCTAssertEqual(viewModel.existingStateValues?.sourceCurrency?.name, "United Arab Emirates Dirham")
    }
    
    func test_ViewModel_CustomAmountAddedState() {
        let viewModel = MockViewModel()
        let state: CurrencyExchangeListViewModel.State = .customAmountEntered(sourceCurrency: nil, amount: 20.0)
        viewModel.state = state
        XCTAssertEqual(viewModel.existingStateValues?.customAmount, 20.0)
    }
    
    func test_ViewModel_State_Transition_From_Amount_To_Currency_State() {
        let viewModel = MockViewModel()
        let customAmountEnteredState: CurrencyExchangeListViewModel.State = .customAmountEntered(sourceCurrency: nil, amount: 20.0)
        viewModel.state = customAmountEnteredState
        
        let sourceCurrency = MockCurrency.dirham
        let sourceCurrencySelectedState: CurrencyExchangeListViewModel.State = .sourceCurrencySelected(sourceCurrency: sourceCurrency, amount: viewModel.existingStateValues?.customAmount ?? defaultAmount)
        viewModel.state = sourceCurrencySelectedState
        
        XCTAssertEqual(viewModel.existingStateValues?.customAmount, 20.0)
        XCTAssertEqual(viewModel.existingStateValues?.sourceCurrency?.exchangeRate, 3.673104)
        XCTAssertEqual(viewModel.existingStateValues?.sourceCurrency?.code, "AED")
        XCTAssertEqual(viewModel.existingStateValues?.sourceCurrency?.name, "United Arab Emirates Dirham")
    }
    
    func test_ViewModel_State_Transition_From_Currency_To_Amount_State() {
        let viewModel = MockViewModel()
        let sourceCurrency = MockCurrency.dirham
        let sourceCurrencySelectedState: CurrencyExchangeListViewModel.State = .sourceCurrencySelected(sourceCurrency: sourceCurrency, amount: viewModel.existingStateValues?.customAmount ?? defaultAmount)
        viewModel.state = sourceCurrencySelectedState
        
        let customAmountEnteredState: CurrencyExchangeListViewModel.State = .customAmountEntered(
            sourceCurrency: viewModel.existingStateValues?.sourceCurrency,
            amount: 20.0
        )
        viewModel.state = customAmountEnteredState
        
        XCTAssertEqual(viewModel.existingStateValues?.customAmount, 20.0)
        XCTAssertEqual(viewModel.existingStateValues?.sourceCurrency?.exchangeRate, 3.673104)
        XCTAssertEqual(viewModel.existingStateValues?.sourceCurrency?.code, "AED")
        XCTAssertEqual(viewModel.existingStateValues?.sourceCurrency?.name, "United Arab Emirates Dirham")
    }
    
    func test_ViewModel_State_Transition_From_Currency_To_NoAmount_State() {
        let viewModel = MockViewModel()
        let sourceCurrency = MockCurrency.dirham
        let sourceCurrencySelectedState: CurrencyExchangeListViewModel.State = .sourceCurrencySelected(sourceCurrency: sourceCurrency, amount: viewModel.existingStateValues?.customAmount ?? defaultAmount)
        viewModel.state = sourceCurrencySelectedState
        
        let customAmountEnteredState: CurrencyExchangeListViewModel.State = .customAmountEntered(
            sourceCurrency: viewModel.existingStateValues?.sourceCurrency,
            amount: 20.0
        )
        viewModel.state = customAmountEnteredState
        
        let noCustomAmountEnteredState: CurrencyExchangeListViewModel.State = .customAmountEntered(
            sourceCurrency: viewModel.existingStateValues?.sourceCurrency,
            amount: 1.0
        )
        viewModel.state = noCustomAmountEnteredState
        XCTAssertNotEqual(viewModel.existingStateValues?.customAmount, 20.0)
        XCTAssertEqual(viewModel.existingStateValues?.customAmount, 1.0)
        XCTAssertEqual(viewModel.existingStateValues?.sourceCurrency?.exchangeRate, 3.673104)
        XCTAssertEqual(viewModel.existingStateValues?.sourceCurrency?.code, "AED")
        XCTAssertEqual(viewModel.existingStateValues?.sourceCurrency?.name, "United Arab Emirates Dirham")
    }
    
    func test_CalculateExchangeRate_For_CurrencySelectedState() {
        let viewModel = MockViewModel()
        let sourceCurrency = MockCurrency.ausDollar
        let state: CurrencyExchangeListViewModel.State = .sourceCurrencySelected(sourceCurrency: sourceCurrency, amount: defaultAmount)
        viewModel.state = state
        
        let rate = viewModel.calculateExchangeRate(currency: sourceCurrency)
        XCTAssertEqual(rate, 2.746747070119708)
    }
}

final private class MockViewModel: CurrencyExchangeListViewModelProtocol {
    init() {
        fetch()
    }
    func fetch() {
        let data = try! JSONDecoder().decode(Live.self, from: APIManager.liveJSON)
        liveData = data
    }
    
    var state: CurrencyExchangeListViewModel.State = .empty
    
    var existingStateValues: (sourceCurrency: CurrencyProtocol?, customAmount: Double?)? {
        switch state {
        case .currenciesFetched, .empty:
            return nil
        case let .customAmountEntered(sourceCurrency, customAmount):
            return (sourceCurrency, customAmount)
        case let .sourceCurrencySelected(sourceCurrency, customAmount):
            return (sourceCurrency, customAmount)
        }
    }
    
    var currencies: [CurrencyProtocol] {
        guard let liveData = liveData else { return [] }
        return liveData.currencies
    }
    
    var liveData: Live? = nil
    
    func calculateExchangeRate(currency: CurrencyProtocol?) -> Double {
        let currentCurrency = MockCurrency.dirham
        return currentCurrency.calculateExchangeRate(sourceCurrency: currency, customAmount: 1.0)
    }
}

private struct MockCurrency: CurrencyProtocol {
    let code: String
    let exchangeRate: Double
    let name: String
}

extension MockCurrency {
    static var dirham: MockCurrency {
        MockCurrency(code: "AED", exchangeRate: 3.673104, name: "United Arab Emirates Dirham")
    }
    
    static var rupee: MockCurrency {
        MockCurrency(code: "PKR", exchangeRate: 156.850375, name: "Pakistani Rupee")
    }
    
    static var moniRiyal: MockCurrency {
        MockCurrency(code: "OMR", exchangeRate: 0.384935, name: "Omani Rial")
    }
    
    static var ausDollar: MockCurrency {
        MockCurrency(code: "AUD", exchangeRate: 1.337256, name: "Australian Dollar")
    }
}
