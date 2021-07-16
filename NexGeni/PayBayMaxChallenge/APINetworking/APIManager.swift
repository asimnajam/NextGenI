//
//  APIManager.swift
//  PayBayMaxChallenge
//
//  Created by Syed Asim Najam on 17/06/2021.
//

import Foundation
import Models

let kAPIManager = APIManager.shared

final class APIManager {
    public static let shared: APIManager = APIManager()
    private let urlSession: URLSession = URLSession.shared
    
    private init() {}
}

protocol LiveAPICommunicator {
    func callLiveAPI(success: @escaping ((Live) -> Void), failure: @escaping ((Error?) -> Void))
}

protocol ListAPICommunicator {
    func callListAPI(success: @escaping ((List) -> Void), failure: @escaping ((Error?) -> Void))
}


extension APIManager: LiveAPICommunicator {
    func callLiveAPI(success: @escaping ((Live) -> Void), failure: @escaping ((Error?) -> Void)) {
        urlSession.performRequest(
            resource: .getLiveData(),
            success: { liveData in
                DispatchQueue.main.async {
                    success(liveData)
                }
            },
            failure: { error in
                failure(error)
            }
        )
    }
}

extension APIManager: ListAPICommunicator {
    func callListAPI(success: @escaping ((List) -> Void), failure: @escaping ((Error?) -> Void)) {
        urlSession.performRequest(
            resource: .getListData(),
            success: { liveData in
                DispatchQueue.main.async {
                    success(liveData)
                }
            },
            failure: { error in
                failure(error)
            }
        )
    }
}
