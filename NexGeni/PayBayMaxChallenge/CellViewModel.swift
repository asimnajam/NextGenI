//
//  CellViewModel.swift
//  PayBayMaxChallenge
//
//  Created by Syed Asim Najam on 20/06/2021.
//

import Foundation
import Utility

struct CellViewModel {
    let currencyName: String
    var exchangeRate: Double
    
    var exRate: Double {
        exchangeRate.cutOffDecimalsAfter(3)
    }
}
