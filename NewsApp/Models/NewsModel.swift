//
//  NewsModel.swift
//  NewsApp
//
//  Created by Lovish Goel on 04/10/22.
//

import Foundation

struct News: Codable {
    let status: String
    let totalResults: Int?
    let articles: [NewsArticle]
}

struct NewsArticle: Codable {
    let source: ArticleSource?
    let author: String?
    let title: String?
    let desc: String?
    let articleUrl: String?
    let imageUrl: String?
    let publishedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case source, author, title, publishedAt
        case desc = "description"
        case articleUrl = "url"
        case imageUrl = "urlToImage"
    }
}

struct ArticleSource: Codable {
    let id: String?
    let name: String?
}
