//
//  HomeCollectionViewCell.swift
//  teste-ios-fractal
//
//  Created by André Levi Oliveira Silva on 25/01/24.
//

import UIKit
import TinyConstraints
import Kingfisher

class HomeCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "HomeCollectionViewCell"
    
    let customView: HomeView = {
        let v = HomeView()
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.customView)
        self.backgroundColor = .clear
        self.configContraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
                   
    private func configContraints() {
        customView.edgesToSuperview()
    }
    
    func configure(_ beer: BeersModel) {
        customView.titleBeersLabel.text = beer.name ?? ""
        customView.textBeersLabel.text = beer.tagline ?? ""
        
        if let imageURL = beer.imageURL, let url = URL(string: imageURL) {
            customView.homeImageView.kf.setImage(with: url)
        }
    }
    
}
