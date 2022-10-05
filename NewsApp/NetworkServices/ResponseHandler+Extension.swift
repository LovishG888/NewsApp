//
//  ResponseHandler+Extension.swift
//  NewsApp
//
//  Created by Lovish Goel on 04/10/22.
//

import Foundation

struct ServiveError: Error, Codable {
    let httpStatus: Int
    let message: String
}

extension ResponseHandler {
    func defaultParseResponse<T: Codable>(data: Data, response: HTTPURLResponse) throws -> T {
        do {
            let jsonObj = try JSONDecoder().decode(T.self, from: data)
            if response.statusCode == 200 {
                return jsonObj
            } else {
                throw ServiveError(httpStatus: response.statusCode, message: "Unknown Error")
            }
        } catch {
            throw ServiveError(httpStatus: response.statusCode, message: error.localizedDescription)
        }
    }
}
