//
//  AppDelegate.swift
//  NexGeniTest
//
//  Created by Syed Asim Najam on 24/06/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.backgroundColor = .white
        self.window =  UIWindow(frame: UIScreen.main.bounds)
        
        let viewController = ViewController()
//            viewModel: CurrencyExchangeListViewModel(liveAPICommunicator: kAPIManager)
//        )
        viewController.view.backgroundColor = .white
        let rootNC = UINavigationController(rootViewController: viewController)
        self.window?.rootViewController = rootNC
        self.window?.makeKeyAndVisible()
        return true
    }
}

