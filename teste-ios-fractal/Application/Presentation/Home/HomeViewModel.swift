//
//  HomeViewModel.swift
//  teste-ios-fractal
//
//  Created by André Levi Oliveira Silva on 25/01/24.
//

import UIKit

protocol HomeViewModelProtocol: AnyObject {
    
}

final class HomeViewModel: NSObject {
    private let coordinator: HomeCoordinating
    
    weak var viewController: HomeViewControllerDisplay?
    
    init(coordinator: HomeCoordinating = HomeCoordinator()) {
        self.coordinator = coordinator
    }
}

extension HomeViewModel: HomeViewModelProtocol {
    
}
