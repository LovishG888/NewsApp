//
//  NewsAPI.swift
//  NewsApp
//
//  Created by Lovish Goel on 04/10/22.
//

import Foundation

struct NewsAPI: APIHandler {
    
    private let topHeadlinesUrl = "https://newsapi.org/v2/top-headlines"
    private let searchUrl = "https://newsapi.org/v2/everything"
    
    func makeRequest(from params: [String: Any]) -> URLRequest? {
        let urlString = params["q"] == nil ? topHeadlinesUrl : searchUrl
        if var url = URL(string: urlString) {
            if params.count > 0 {
                url = setQueryParams(params: params, url: url)
            }
            var urlRequest = URLRequest(url: url)
            setDefaultHeaders(request: &urlRequest)
            urlRequest.httpMethod = "GET"
            return urlRequest
        }
        return nil
    }
    
    func parseResponse(data: Data, response: HTTPURLResponse) throws -> News {
        return try defaultParseResponse(data: data, response: response)
    }
}
