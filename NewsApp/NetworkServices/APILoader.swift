//
//  APILoader.swift
//  NewsApp
//
//  Created by Lovish Goel on 04/10/22.
//

import Foundation

class APILoader<T: APIHandler> {
    let apiRequest: T
    let urlSession: URLSession
    
    init(apiRequest: T, urlSession: URLSession = .shared) {
        self.apiRequest = apiRequest
        self.urlSession = urlSession
    }
    
    func loadApiRequest(requestData: T.RequestType, completion: @escaping (T.ResponseType?, Error?) -> ()) {
        if let urlRequest = apiRequest.makeRequest(from: requestData) {
            urlSession.dataTask(with: urlRequest) { (data, response, error) in
                guard let data = data, let response = response as? HTTPURLResponse else {
                    return completion(nil, error)
                }
                do {
                    let parsedResponse = try self.apiRequest.parseResponse(data: data, response: response)
                    completion(parsedResponse, nil)
                } catch {
                    completion(nil, error)
                }
            }.resume()
        }
    }
}
