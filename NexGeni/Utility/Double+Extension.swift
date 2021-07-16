//
//  Double+Extension.swift
//  Utility
//
//  Created by Syed Asim Najam on 20/06/2021.
//

import Foundation

extension Double {
    public func cutOffDecimalsAfter(_ places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self*divisor).rounded(.towardZero) / divisor
    }
}
