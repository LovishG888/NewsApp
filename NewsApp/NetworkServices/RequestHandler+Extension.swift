//
//  RequestHandler+Extension.swift
//  NewsApp
//
//  Created by Lovish Goel on 04/10/22.
//

import Foundation

extension RequestHandler {
    
    func setParams(params: [String: Any], request: inout URLRequest) {
        if params.count > 0 {
            if let jsonObj = try? JSONSerialization.data(withJSONObject: params, options: []) {
                request.httpBody = jsonObj
            }
        }
    }
    
    func setQueryParams(params: [String: Any], url: URL) -> URL {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = params.map{ element in
            URLQueryItem(name: element.key, value: String(describing: element.value))
        }
        
        return components?.url ?? url
    }
    
    func setDefaultHeaders(request: inout URLRequest) {
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    }
}
