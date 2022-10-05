//
//  Coordinator.swift
//  NewsApp
//
//  Created by Lovish Goel on 04/10/22.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController {get set}
    var childCoordinators: [Coordinator] {get set}
    
    func start()
}

