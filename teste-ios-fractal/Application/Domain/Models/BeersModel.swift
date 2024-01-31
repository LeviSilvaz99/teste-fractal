//
//  BeersModel.swift
//  teste-ios-fractal
//
//  Created by André Levi Oliveira Silva on 29/01/24.
//

import Foundation

struct BeersModel: Codable {
    let name, description, tagline: String?
    let imageURL: String?
    let id: Int?
    
    enum CodingKeys: String, CodingKey {
        case name, description, tagline, id
        case imageURL = "image_url"
    }
    
    var isFavorite: Bool {
           get {
               // Recuperar o estado de favorito do UserDefaults
               return UserDefaults.standard.bool(forKey: "\(name ?? "")_isFavorite")
           }
           set {
               // Salvar o estado de favorito no UserDefaults
               UserDefaults.standard.set(newValue, forKey: "\(name ?? "")_isFavorite")
           }
       }
}
