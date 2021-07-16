//
//  ImageManager.swift
//  Utility
//
//  Created by Syed Asim Najam on 24/06/2021.
//

import Foundation
import UIKit

final public class ImageManager {
    private static let semophore = DispatchSemaphore(value: 1)
    private static let dispatchQueue = DispatchQueue(label: "ImageFetchingQueue", attributes: .concurrent)
    private static let imageCache = NSCache<NSString, NSData>()
    
    private static func fetchImage(from urlString: String, completion: @escaping (UIImage?, Error?) -> ()) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let data = data {
                imageCache.setObject(data as NSData, forKey: urlString as NSString)
                completion(UIImage(data: data), nil)
            }
            semophore.signal()
        }.resume()
    }
}

extension ImageManager {
    public static func fetch(from urlString: String, completion: @escaping (UIImage?, Error?) -> ()) {
        if let imageData = imageCache.object(forKey: urlString as NSString) {
            completion(UIImage(data: imageData as Data), nil)
        } else {
            dispatchQueue.async {
                semophore.wait()
                fetchImage(from: urlString, completion: completion)
            }
        }
    }
}
