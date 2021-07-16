//
//  LiveViewTableViewCellExtension.swift
//  PayBayMaxChallenge
//
//  Created by Syed Asim Najam on 20/06/2021.
//

import Foundation
import UIComponents

extension LiveViewTableViewCell {
    func config(viewModel: CellViewModel, kind: LiveView.Kind) {
        config(
            currencyName: viewModel.currencyName,
            exRate: "\(viewModel.exRate)",
            kind: kind
        )
    }
}
