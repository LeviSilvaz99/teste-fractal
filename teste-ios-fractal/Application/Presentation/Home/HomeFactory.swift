//
//  HomeFactory.swift
//  teste-ios-fractal
//
//  Created by André Levi Oliveira Silva on 25/01/24.
//

import UIKit

class HomeFactory {
    
    static func make() -> HomeViewController {
        let coordinator: HomeCoordinating = HomeCoordinator()
        let viewModel = HomeViewModel(coordinator: coordinator)
        let viewController = HomeViewController(viewModel: viewModel)
        
        coordinator.viewController = viewController
        viewModel.viewController = viewController
        
        return viewController
    }
}
