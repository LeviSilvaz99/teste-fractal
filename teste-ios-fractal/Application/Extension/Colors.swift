//
//  Colors.swift
//  teste-ios-fractal
//
//  Created by André Levi Oliveira Silva on 26/01/24.
//

import UIKit

enum Colors {
    
    case white
    case blue
    case gray
    case black
    case graySmall
    case red
    
    var uiColor: UIColor {
        switch self {
        case .gray:
            return UIColor(named: "colorGray") ?? UIColor.gray
        case .blue:
            return UIColor(named: "colorBlue") ?? UIColor.blue
        case .white:
            return UIColor(named: "colorWhite") ?? UIColor.white
        case .black:
            return UIColor(named: "colorBlack") ?? UIColor.black
        case .graySmall:
            return UIColor(named: "colorSmallGray") ?? UIColor.gray
        case .red:
            return UIColor.red
        }
        
    }
}
