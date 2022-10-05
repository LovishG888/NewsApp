//
//  NewsAppTests.swift
//  NewsAppTests
//
//  Created by Lovish Goel on 04/10/22.
//

import XCTest
@testable import NewsApp

class NewsArticleViewModelTests: XCTestCase {

    var viewModel: NewsArticleViewModel?
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let article = NewsArticle(source: ArticleSource(id: nil, name: "CNBC"), author: "Holly Ellyatt", title: "Some Title", desc: "Some Description", articleUrl: nil, imageUrl: nil, publishedAt: nil)
        viewModel = NewsArticleViewModel(article: article)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testNewsArticleTitle() {
        XCTAssertNotNil(viewModel?.title)
        XCTAssertEqual(viewModel?.title, "Some Title")
    }
    
    func testNewsArticleDescription() {
        XCTAssertNotNil(viewModel?.description)
        XCTAssertEqual(viewModel?.description, "Some Description")
    }
    
    func testNewsArticleAuthor() {
        XCTAssertNotNil(viewModel?.author)
        XCTAssertEqual(viewModel?.author, "Holly Ellyatt")
    }
    
    func testNewsArticleImage() {
        XCTAssertNotNil(viewModel?.imageURL)
        XCTAssertEqual(viewModel?.imageURL, "")
    }
    
}
