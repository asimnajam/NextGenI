//
//  ViewController.swift
//  NexGeniTest
//
//  Created by Syed Asim Najam on 24/06/2021.
//

//import UIKit
//import Networking
//
//class ViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        kAPIManager.getProducts(success: { products in
//            print(products)
//        }, failure: { error in
//            print(error)
//        })
//        // Do any additional setup after loading the view.
//    }
//
//
//}

import UIKit
import Models
import Utility
import UIComponents

final class ViewController: UIViewController {
    var products: Products?
    private var contentView: LiveView!
//    let viewModel: CurrenciesListViewModel
    
    init() {
//        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        config()
//        fetchData()
        kAPIManager.getProductDetail(
            by: "",
            success: { productDetail in
                print(productDetail)
            }, failure: { error in
                print(error)
            }
        )
    }
    
    private func setup() {
        contentView = LiveView.make()
        view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .red
        contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0.0).isActive = true
        contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        contentView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0.0).isActive = true
        contentView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0.0).isActive = true
        view.layoutIfNeeded()
        view.layoutSubviews()
        contentView.layoutIfNeeded()
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
//        viewModel.onListFetched = { [weak self] listData in
//            self?.contentView.tableView.reloadData()
//        }
//        viewModel.fetch()
//        ImageManager.fetch(from: "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/5a90871e-408a-46da-a43c-210348a67082") { (image, error) in
//            print(image)
//        }
        kAPIManager.getProducts(success: { [weak self] products in
            print(products)
            self?.products = products
            self?.contentView.tableView.reloadData()
        }, failure: { error in
            print(error)
        })
    }
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products?.data.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let liveViewTableViewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: LiveViewTableViewCell.self)) as? LiveViewTableViewCell
        guard let cell = liveViewTableViewCell,
              let product = products?.data.get(indexPath.row)
        else {
            return UITableViewCell()
        }
//        let cellViewModel = CellViewModel(
//            currencyName: "\(currency.code) - \(currency.name)",
//            exchangeRate: 0.0
//        )
        ImageManager.fetch(from: product.goodsImage) { (image, error) in
            DispatchQueue.main.async {
                cell.productImageView.image = image
            }
            
        }
        cell.config(currencyName: product.goodsTitle, exRate: product.subTitle)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let currency = products?.data.get(indexPath.row)
        else {
            return
        }
        navigationController?.pushViewController(DetailViewController(), animated: true)
//        viewModel.onCurrencySelection?(currency as! Currency)
//        navigationController?.popViewController(animated: true)
    }
}
