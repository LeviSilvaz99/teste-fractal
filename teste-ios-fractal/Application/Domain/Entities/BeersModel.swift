//
//  BeersModel.swift
//  teste-ios-fractal
//
//  Created by André Levi Oliveira Silva on 29/01/24.
//

import Foundation

public struct BeersModel: Codable {
    let name, description, tagline: String?
    let imageURL: String?
    let id: Int?
    
    enum CodingKeys: String, CodingKey {
        case name, description, tagline, id
        case imageURL = "image_url"
    }
}
