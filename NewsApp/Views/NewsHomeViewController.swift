//
//  ViewController.swift
//  NewsApp
//
//  Created by Lovish Goel on 04/10/22.
//

import UIKit

class NewsHomeViewController: UIViewController {
    
    var coordinator: AppCoordinator?
    var viewModel = NewsListViewModel()
    private let searchVC = UISearchController(searchResultsController: nil)
    
    private lazy var tableView: UITableView = {
        let t = UITableView()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.backgroundColor = .white
        t.register(NewsTableViewCell.self, forCellReuseIdentifier: viewModel.reuseID)
        t.delegate = self
        t.dataSource = self
        t.rowHeight = UITableView.automaticDimension
        return t
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "News"
        setupUI()
        fetchNews()
        createSearchBar()
    }
    
    private func createSearchBar() {
        navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func fetchNews(query: String? = nil) {
        var params = [String: Any]()
        if let query = query {
            params["q"] = query
        } else {
            params["country"] = "us"
        }
        params["apiKey"] = APIKey.key
        viewModel.getNews(params: params) { [weak self] articles in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.searchVC.dismiss(animated: true, completion: nil)
            }
        }
    }
}

extension NewsHomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.newsArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.reuseID, for: indexPath) as? NewsTableViewCell
        cell?.configureCell(model: viewModel.newsArticles[indexPath.row])
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 154.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newsArticle = viewModel.newsArticles[indexPath.row]
        coordinator?.showNewsArticleDetails(model: newsArticle)
        
    }
    
}

extension NewsHomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        
        self.fetchNews(query: text)
    }
}

