//
//  ViewController.swift
//  teste-ios-fractal
//
//  Created by André Levi Oliveira Silva on 25/01/24.
//

import UIKit

public protocol ViewConfiguration: AnyObject {
    func setupConstraints()
    func buildViewHierarchy()
    func configureViews()
    func bindViewModel()
    func configureNavBar()
}

class ViewController<ViewModel, V: UIView>: UIViewController,ViewConfiguration {
    public let viewModel: ViewModel

    public var rootView: V? {
        return self.view as? V
    }

    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open override func viewDidLoad() {
        super.viewDidLoad()

        buildViewHierarchy()
        configureViews()
        setupConstraints()
        configureNavBar()
        bindViewModel()
        
        
    }
    
    public override func loadView() {
        view = V()
    }

    open func bindViewModel() { }

    open func configureViews() { }

    open func buildViewHierarchy() { }

    open func setupConstraints() { }

    open func configureNavBar() { }
}
