//
//  NewsDetailViewController.swift
//  NewsApp
//
//  Created by Lovish Goel on 04/10/22.
//

import UIKit

class NewsDetailViewController: UIViewController {

    var viewModel: NewsArticleViewModel
    var coordinator: AppCoordinator?
    
    private lazy var newsImage: UIImageView = {
        let iM = UIImageView()
        iM.contentMode = .scaleAspectFit
        iM.clipsToBounds = true
        iM.translatesAutoresizingMaskIntoConstraints = false
        return iM
    }()
    
    private lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        l.textColor = .black
        return l
    }()
    
    private lazy var descLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        l.textColor = .gray
        return l
    }()
    
    private lazy var bottomView: UIView = {
        let view: UIView = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.alpha = 0.5
        return view
    }()
    
    private lazy var authorLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 1
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 14, weight: .light)
        l.textColor = .white
        return l
    }()
    
    init(_ viewModel: NewsArticleViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(newsImage)
        view.addSubview(titleLabel)
        view.addSubview(descLabel)
        view.addSubview(bottomView)
        bottomView.addSubview(authorLabel)
        
        NSLayoutConstraint.activate([
            newsImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            newsImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newsImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newsImage.heightAnchor.constraint(equalToConstant: 260),
            
            titleLabel.topAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            descLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            descLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 80),
            
            authorLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 16),
            authorLabel.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -16),
            authorLabel.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor)

        ])
    }
    
    private func setupData() {
        self.titleLabel.text = viewModel.title
        self.descLabel.text = viewModel.description
        self.authorLabel.text = "Published By:- \(viewModel.author)"
        
        DispatchQueue.global().async {
            NetworkManager.shared.getImage(urlString: self.viewModel.imageURL) { [weak self] (data, error) in
                guard let data = data else {
                    return
                }
                DispatchQueue.main.async {
                    self?.newsImage.image = UIImage(data: data)
                }
            }
        }
    }
    

}
