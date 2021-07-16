//
//  LiveView.swift
//  PayBayMaxChallenge
//
//  Created by Syed Asim Najam on 17/06/2021.
//

import Foundation
import UIKit

public final class LiveView: UIView {
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
    
    private init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .white
        layoutIfNeeded()
        addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: topAnchor, constant: 0.0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0.0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0.0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0.0).isActive = true
        layoutIfNeeded()
    }
}

extension LiveView {
    public static func make() -> LiveView {
        let view = LiveView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}
