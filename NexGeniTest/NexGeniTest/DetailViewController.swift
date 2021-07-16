//
//  DetailViewController.swift
//  NexGeniTest
//
//  Created by Syed Asim Najam on 24/06/2021.
//

import UIKit

class DetailViewController: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        kAPIManager.getProductDetail(
            by: "",
            success: { productDetail in
                print(productDetail)
            }, failure: { error in
                print(error)
            }
        )
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
