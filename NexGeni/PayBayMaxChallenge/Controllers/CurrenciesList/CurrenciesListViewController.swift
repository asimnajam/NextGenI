//
//  CurrenciesListViewController.swift
//  PayBayMaxChallenge
//
//  Created by Syed Asim Najam on 19/06/2021.
//

import UIKit
import Models
import Utility
import UIComponents

final class CurrenciesListViewController: UIViewController {
    private let contentView = LiveView.make(kind: .currencyListView)
    let viewModel: CurrenciesListViewModel
    
    init(viewModel: CurrenciesListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        config()
        fetchData()
    }
    
    private func setup() {
        view.addSubview(contentView)
        contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0.0).isActive = true
        contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0.0).isActive = true
        contentView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0.0).isActive = true
        contentView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0.0).isActive = true
    }
    
    private func config() {
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
        contentView.tableView.register(
            LiveViewTableViewCell.self,
            forCellReuseIdentifier: String(describing: LiveViewTableViewCell.self)
        )
    }
    
    private func fetchData() {
        viewModel.onListFetched = { [weak self] listData in
            self?.contentView.tableView.reloadData()
        }
        viewModel.fetch()
    }
}


extension CurrenciesListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.currencies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let liveViewTableViewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: LiveViewTableViewCell.self)) as? LiveViewTableViewCell
        guard let cell = liveViewTableViewCell,
              let currency = viewModel.currencies.get(indexPath.row)
        else {
            return UITableViewCell()
        }
        let cellViewModel = CellViewModel(
            currencyName: "\(currency.code) - \(currency.name)",
            exchangeRate: 0.0
        )
        cell.config(viewModel: cellViewModel, kind: contentView.kind)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let currency = viewModel.currencies.get(indexPath.row)
        else {
            return
        }
        viewModel.onCurrencySelection?(currency as! Currency)
        navigationController?.popViewController(animated: true)
    }
}
