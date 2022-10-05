//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Lovish Goel on 04/10/22.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    private lazy var newsImage: UIImageView = {
        let iM = UIImageView()
        iM.contentMode = .scaleAspectFit
        iM.layer.cornerRadius = 6
        iM.clipsToBounds = true
        iM.translatesAutoresizingMaskIntoConstraints = false
        return iM
    }()
    
    private lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 2
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        l.textColor = .black
        return l
    }()
    
    private lazy var descLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 3
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        l.textColor = .gray
        return l
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .white
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(titleLabel)
        addSubview(descLabel)
        addSubview(newsImage)
        
        NSLayoutConstraint.activate([
            newsImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            newsImage.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            newsImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            newsImage.widthAnchor.constraint(equalToConstant: 144),
            
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: newsImage.leadingAnchor, constant: -16),
            
            descLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            descLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            descLabel.trailingAnchor.constraint(equalTo: newsImage.leadingAnchor, constant: -16),
            descLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16)
        ])
    }
    
    func configureCell(model: NewsArticleViewModel) {
        self.titleLabel.text = model.title
        self.descLabel.text = model.description
        DispatchQueue.global().async {
            NetworkManager.shared.getImage(urlString: model.imageURL) { [weak self] (data, error) in
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
