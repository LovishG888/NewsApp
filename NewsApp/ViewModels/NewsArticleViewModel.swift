//
//  NewsArticleViewModel.swift
//  NewsApp
//
//  Created by Lovish Goel on 04/10/22.
//

import Foundation

struct NewsArticleViewModel {
    var author: String
    var title: String
    var description: String
    var imageURL: String
    
    init(article: NewsArticle) {
        self.author = article.author ?? ""
        self.title = article.title ?? ""
        self.description = article.desc ?? "No Description"
        self.imageURL = article.imageUrl ?? ""
    }

}
