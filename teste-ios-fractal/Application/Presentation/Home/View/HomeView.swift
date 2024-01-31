//
//  HomeCollectionView.swift
//  teste-ios-fractal
//
//  Created by André Levi Oliveira Silva on 26/01/24.
//

import UIKit
import TinyConstraints


class HomeView: UIView {
    
    ///views
    private lazy var bgView: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 8
        v.backgroundColor = Colors.gray.uiColor
        return v
    }()
    
    lazy var homeImageView: UIImageView = {
        let i = UIImageView()
        i.image = UIImage(named: "image")
        i.contentMode = .scaleAspectFit
        return i
    }()
    
    lazy var titleBeersLabel: UILabel = {
        let l = UILabel()
        l.text = "AB: 01"
        l.font = UIFont(name: "Montserrat-Bold", size: 18)
        l.numberOfLines = 1
        l.textColor = Colors.black.uiColor
        return l
    }()
    
    lazy var textBeersLabel: UILabel = {
        let l = UILabel()
        l.text = "Vanilla Bean Infused Belgian Quad."
        l.font = UIFont(name: "Montserrat-Regular", size: 14)
        l.numberOfLines = 0
        l.textColor = Colors.graySmall.uiColor
        return l
    }()
    
    private lazy var righButton: UIImageView = {
        let i = UIImageView()
        i.image = UIImage(named: "right-button")
        i.contentMode = .scaleAspectFit
        return i
    }()
    
    private lazy var heartButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        button.tintColor = Colors.black.uiColor
        button.addTarget(self, action: #selector(heartButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    @objc private func heartButtonTapped() {
        let isHeartFilled = heartButton.tintColor == Colors.red.uiColor
        heartButton.tintColor = isHeartFilled ? Colors.black.uiColor : Colors.red.uiColor
    }


    private func setupLayout() {
        addSubview(bgView)
        bgView.addSubview(homeImageView)
        bgView.addSubview(titleBeersLabel)
        bgView.addSubview(textBeersLabel)
        bgView.addSubview(righButton)
        bgView.addSubview(heartButton)
    }
    
    private func setupConstraints() {
        bgView.height(80)
        bgView.topToSuperview(offset: 16)
        bgView.leadingToSuperview(offset: 16)
        bgView.trailingToSuperview(offset: 16)
        bgView.bottomToSuperview()
        
        homeImageView.height(46)
        homeImageView.width(46)
        homeImageView.leadingToSuperview(offset: 8)
        homeImageView.centerYToSuperview()
        
        titleBeersLabel.leadingToTrailing(of: homeImageView, offset: 4)
        titleBeersLabel.top(to: homeImageView, offset: 1)
        titleBeersLabel.width(200)
        
        righButton.trailingToSuperview(offset: 8)
        righButton.centerYToSuperview()
        righButton.width(16)
        righButton.height(16)
        
        heartButton.trailingToLeading(of: righButton, offset: -8)
        heartButton.centerYToSuperview()
        
        textBeersLabel.leadingToTrailing(of: homeImageView, offset: 4)
        textBeersLabel.topToBottom(of: titleBeersLabel, offset: 4)
    }
    
    init() {
        super.init(frame: .zero)
        setupLayout()
        setupConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")

    }
}
