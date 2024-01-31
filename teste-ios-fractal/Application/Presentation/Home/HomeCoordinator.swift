//
//  HomeCoordinator.swift
//  teste-ios-fractal
//
//  Created by André Levi Oliveira Silva on 25/01/24.
//

import UIKit

enum HomeConfigureAction {
    
}

protocol HomeCoordinating: AnyObject {
    var viewController: UIViewController? { get set }
    func perform(action: HomeConfigureAction)
}

final class HomeCoordinator {
    weak var viewController: UIViewController?
}

extension HomeCoordinator: HomeCoordinating {
    func perform(action: HomeConfigureAction) {
        switch action {
            
        default:
            break
        }
    }
}
