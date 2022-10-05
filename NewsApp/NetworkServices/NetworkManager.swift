//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Lovish Goel on 04/10/22.
//

import Foundation

class NetworkManager {
    private let imageCache = NSCache<NSString, NSData>()
    
    static let shared = NetworkManager()
    private init() {}
    
    func getImage(urlString: String, completion: @escaping (Data?, Error?)  -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil, nil)
            return
        }
        
        if let cachedImage = imageCache.object(forKey: NSString(string: urlString)) {
            completion(cachedImage as Data, nil)
        } else {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard error == nil, let data = data else {
                    completion(nil, error)
                    return
                }
                self.imageCache.setObject(data as NSData, forKey: NSString(string: urlString))
                completion(data, nil)
            }.resume()
        }
    }
}
