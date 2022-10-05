//
//  NewsListViewModel.swift
//  NewsApp
//
//  Created by Lovish Goel on 04/10/22.
//

import Foundation

class NewsListViewModel {
    
    var newsArticles = [NewsArticleViewModel]()
    let reuseID = "news"
    
    func getNews(params: [String: Any], completion: @escaping ([NewsArticleViewModel]) -> Void) {
        
        let request = NewsAPI()
        
        let apiLoader = APILoader(apiRequest: request)
        apiLoader.loadApiRequest(requestData: params) { (newModel, error) in
            guard let news = newModel else {
                return
            }
            let newsVM = news.articles.compactMap(NewsArticleViewModel.init)
            DispatchQueue.main.async {
                self.newsArticles = newsVM
                completion(newsVM)
            }
        }
    }
}
