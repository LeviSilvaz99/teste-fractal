//
//  HomeDetailFactory.swift
//  teste-ios-fractal
//
//  Created by André Levi Oliveira Silva on 01/02/24.
//

import Foundation

class HomeDetailFactory {
    
    static func make() -> HomeViewController {
        let coordinator: HomeCoordinating = HomeCoordinator()
        let viewModel = HomeViewModel(coordinator: coordinator)
        let viewController = HomeViewController(viewModel: viewModel)
        
        coordinator.viewController = viewController
        viewModel.viewController = viewController
        
        return viewController
    }
}
