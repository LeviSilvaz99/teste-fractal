//
//  HomeDetailCoordinator.swift
//  teste-ios-fractal
//
//  Created by André Levi Oliveira Silva on 01/02/24.
//

import UIKit

enum HomeDetailConfigureAction {
    case backButtonTapped
}

protocol HomeDetailCoordinating: AnyObject {
    var viewController: UIViewController? { get set }
    func perform(action: HomeDetailConfigureAction)
}

final class HomeDetailCoordinator {
    weak var viewController: UIViewController?
}

extension HomeDetailCoordinator: HomeDetailCoordinating {
    func perform(action: HomeDetailConfigureAction) {
        switch action {
        case .backButtonTapped:
            viewController?.navigationController?.popViewController(animated: true)
        default:
            break
        }
    }
}
