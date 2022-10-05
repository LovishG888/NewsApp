//
//  AppCoordinator.swift
//  NewsApp
//
//  Created by Lovish Goel on 04/10/22.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = NewsHomeViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showNewsArticleDetails(model: NewsArticleViewModel) {
        let detailVC = NewsDetailViewController(model)
        detailVC.coordinator = self
        navigationController.pushViewController(detailVC, animated: true)
    }
}
