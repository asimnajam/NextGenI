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

