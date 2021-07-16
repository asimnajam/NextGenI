//
//  ViewController.swift
//  PayBayMaxChallenge
//
//  Created by Syed Asim Najam on 17/06/2021.
//

import UIKit
import Networking
import Models
import UIComponents
import Utility

final class CurrencyExchangeListViewController: UIViewController {
    private let contentView = LiveView.make(kind: .currencyExchangeView)
    private let viewModel: CurrencyExchangeListViewModel
    
    init(viewModel: CurrencyExchangeListViewModel) {
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
        setupNavigationBar()
        fetchData()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = AppStrings.currency
        
        let button = UIButton(type: .custom)
        button.setTitle(AppStrings.list, for: .normal)
        button.addTarget(self, action: #selector(showListController), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: button)
        navigationItem.rightBarButtonItem = barButton
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
        
        contentView.amountDidChanged = viewModel.amountDidChanged
    }
    
    
    
    @objc func showListController() {
        let currenciesListViewModel = CurrenciesListViewModel(listAPICommunicator: kAPIManager, currenciesExchangeRates: viewModel.currencies)
        let listViewController = CurrenciesListViewController(viewModel: currenciesListViewModel)
        currenciesListViewModel.onCurrencySelection = viewModel.onCurrencySelection
        navigationController?.pushViewController(listViewController, animated: true)
    }
    
    private func fetchData() {
        observeViewModelState()
        viewModel.onListFetched = { [weak self] listData in
            self?.contentView.tableView.reloadData()
        }
        viewModel.fetch()
    }
    
    private func observeViewModelState() {
        viewModel.onStateChange = { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .empty:
                break
            case .currenciesFetched:
                self.contentView.tableView.reloadData()
            case .customAmountEntered:
                self.contentView.tableView.reloadData()
            case let .sourceCurrencySelected(sourceCurrency, _):
                self.contentView.setCurrency(text: sourceCurrency.code)
                self.contentView.tableView.reloadData()
            }
        }
    }
}


extension CurrencyExchangeListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.rowsCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let liveViewTableViewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: LiveViewTableViewCell.self)) as? LiveViewTableViewCell
        guard let cell = liveViewTableViewCell,
              let currency = viewModel.currency(at: indexPath.row) else {
            return UITableViewCell()
        }
        
        let cellViewModel = viewModel.cellViewModel(currency: currency)
        cell.config(
            viewModel: cellViewModel,
            kind: contentView.kind
        )
        return cell
    }
}
