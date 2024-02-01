//
//  HomeDetailViewModel.swift
//  teste-ios-fractal
//
//  Created by André Levi Oliveira Silva on 31/01/24.
//

import UIKit

protocol HomeDetailViewModelProtocol: AnyObject {
    
}

final class HomeDetailViewModel: NSObject {
    public let coordinator: HomeDetailCoordinating
    
    weak var viewController: HomeViewControllerDisplay?
    
    init(coordinator: HomeDetailCoordinating = HomeDetailCoordinator()) {
        self.coordinator = coordinator
    }
    
    var beers: BeersModel?
    
}

extension HomeDetailViewModel: HomeDetailViewModelProtocol {
    
}
