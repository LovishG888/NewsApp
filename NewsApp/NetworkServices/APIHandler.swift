//
//  APIHandler.swift
//  NewsApp
//
//  Created by Lovish Goel on 04/10/22.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

protocol RequestHandler {
    associatedtype RequestType
    func makeRequest(from data: RequestType) -> URLRequest?
}

protocol ResponseHandler {
    associatedtype ResponseType
    func parseResponse(data: Data, response: HTTPURLResponse) throws -> ResponseType
}

typealias APIHandler = RequestHandler & ResponseHandler
