//
//  HomeDetailViewController.swift
//  teste-ios-fractal
//
//  Created by André Levi Oliveira Silva on 29/01/24.
//

import UIKit
import TinyConstraints
import Kingfisher

public protocol HomeDetailViewControllerDisplay: AnyObject {
    
}

class HomeDetailViewController: UIViewController {
    
    lazy var titleBeersLabel: UILabel = {
        let l = UILabel()
        l.text = " asdasdasdasda "
        l.font = UIFont(name: "Montserrat-Bold", size: 24)
        l.numberOfLines = 1
        l.textColor = Colors.black.uiColor
        return l
    }()
    
    lazy var textBeersLabel: UILabel = {
        let l = UILabel()
        l.text = " asdasdasdasda "
        l.font = UIFont(name: "Montserrat-Bold", size: 12)
        l.numberOfLines = 1
        l.textColor = Colors.black.uiColor
        return l
    }()
    
    lazy var descriptionLabel: UILabel = {
        let l = UILabel()
        l.text = " asdasdasdasda "
        l.font = UIFont(name: "Montserrat-Regular", size: 14)
        l.numberOfLines = 0
        l.textColor = Colors.black.uiColor
        return l
    }()
    
    lazy var imageDetailImageView: UIImageView = {
        let i = UIImageView()
        i.contentMode = .scaleAspectFit
        return i
    }()
    
    var beers: BeersModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupConstraint()
        setupUI(self.beers)
        backAction()
    }

}

extension HomeDetailViewController {
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupUI(_ beer: BeersModel?) {
        if let beer = beers {
            titleBeersLabel.text = beer.name
            textBeersLabel.text = beer.tagline
            descriptionLabel.text = beer.description
            
            if let imageURL = beer.imageURL, let url = URL(string: imageURL) {
                imageDetailImageView.kf.setImage(
                    with: url,
                    placeholder: UIImage(named: "image"),
                    options: [.transition(.fade(0.2)), .cacheOriginalImage])
            }
            
        }
    }
    
    private func backAction() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back-button"), style: .done, target: self, action: #selector(backButtonTapped))
        
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        view.addSubview(titleBeersLabel)
        view.addSubview(imageDetailImageView)
        view.addSubview(textBeersLabel)
        view.addSubview(descriptionLabel)
    }
    
    private func setupConstraint() {
        imageDetailImageView.leadingToSuperview(offset: 16)
        imageDetailImageView.topToSuperview(offset: 27, usingSafeArea: true)
        imageDetailImageView.height(74)
        imageDetailImageView.width(74)
        
        titleBeersLabel.leadingToTrailing(of: imageDetailImageView, offset: 16)
        titleBeersLabel.trailingToSuperview(offset: 16)
        titleBeersLabel.topToSuperview(offset: 38, usingSafeArea: true)
        
        textBeersLabel.topToBottom(of: titleBeersLabel, offset: 8)
        textBeersLabel.leading(to: titleBeersLabel)
        textBeersLabel.trailing(to: titleBeersLabel)
        
        descriptionLabel.topToBottom(of: textBeersLabel, offset: 44)
        descriptionLabel.leading(to: imageDetailImageView)
        descriptionLabel.trailingToSuperview(offset: 16)
        
    }
}

extension HomeDetailViewController: HomeViewControllerDisplay {
    func reloadData(with beers: [BeersModel]) {
        
    }

    func reloadData() {
        
    }
    
    
}
