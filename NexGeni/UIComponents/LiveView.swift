//
//  LiveView.swift
//  PayBayMaxChallenge
//
//  Created by Syed Asim Najam on 17/06/2021.
//

import Foundation
import UIKit

public final class LiveView: UIView {
    public enum Kind {
        case currencyListView
        case currencyExchangeView
    }
    
    public var amountDidChanged: ((Double) -> Void)?
    public let kind: Kind
    
    private let selectedCurrencyLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.textColor = .lightGray
        label.numberOfLines = 1
        label.textAlignment = .center
        label.text = "Selected Currency"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let selectedCurrencyName: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.textColor = .darkGray
        label.numberOfLines = 1
        label.textAlignment = .center
        label.text = "- - -"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var labelsStackView: UIStackView = {
        let btnArray = [selectedCurrencyLabel, selectedCurrencyName]
        let stackView = UIStackView(arrangedSubviews: btnArray)
        stackView.spacing = 12.0
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let schooNameField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Amount"
        textField.textColor = .white
        textField.keyboardType = .decimalPad
        textField.backgroundColor = .lightText
        textField.layer.cornerRadius = 5.0
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    public let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60.0
        tableView.backgroundColor = .white
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = UIView()
        tableView.keyboardDismissMode = .interactive
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private init(kind: Kind) {
        self.kind = kind
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .white
        switch kind {
        case .currencyListView:
            setupForCurrencyListView()
        case .currencyExchangeView:
            setupForCurrencyExchangeListView()
        }
    }
    
    private func setupForCurrencyListView() {
        addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: topAnchor, constant: 10.0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0.0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0.0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0.0).isActive = true
    }
    
    private func setupForCurrencyExchangeListView() {
        addSubview(labelsStackView)
        labelsStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10.0).isActive = true
        labelsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0).isActive = true
        labelsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0).isActive = true
        labelsStackView.heightAnchor.constraint(equalToConstant: 40.0).isActive = true

        addSubview(schooNameField)
        schooNameField.topAnchor.constraint(equalTo: labelsStackView.bottomAnchor, constant: 10.0).isActive = true
        schooNameField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0).isActive = true
        schooNameField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0).isActive = true
        schooNameField.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        
        addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: schooNameField.bottomAnchor, constant: 10.0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0.0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0.0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0.0).isActive = true
        
        schooNameField.backgroundColor = .gray
        schooNameField.layer.cornerRadius = 5.0
        schooNameField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text,
           let amount = Double(text) {
            amountDidChanged?(amount)
        } else {
            amountDidChanged?(1.0)
        }
    }
    
    public func setCurrency(text: String) {
        selectedCurrencyName.text = text
    }
}

extension LiveView {
    public static func make(kind: LiveView.Kind) -> LiveView {
        let view = LiveView(kind: kind)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}
