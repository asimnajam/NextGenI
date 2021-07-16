//
//  LiveViewTableViewCell.swift
//  PayBayMaxChallenge
//
//  Created by Syed Asim Najam on 17/06/2021.
//

import UIKit

final public class LiveViewTableViewCell: UITableViewCell {
    private let currencyNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.textColor = .gray
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let currencyExchangeRateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.textColor = .gray
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layoutIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        backgroundColor = .white
        contentView.addSubview(currencyNameLabel)
        contentView.addSubview(currencyExchangeRateLabel)
        
        currencyNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0).isActive = true
        currencyNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0.0).isActive = true
        
        currencyExchangeRateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0).isActive = true
        currencyExchangeRateLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0.0).isActive = true
    }
    
    public func config(currencyName: String, exRate: String, kind: LiveView.Kind) {
        currencyNameLabel.text = currencyName
        currencyExchangeRateLabel.text = exRate
        currencyExchangeRateLabel.isHidden = kind == .currencyListView
    }
}
