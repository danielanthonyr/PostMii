//
//  ThemeColors.swift
//  PostMii
//
//  Created by Daniel Romero on 2023-09-28.
//

import Foundation
import UIKit

struct Colors {
    
    static let lavender1 = "9EA1D4"
    
    static let minty1 = "DFEBEB"
    
    static let green1 = "A8D1D1"
    
    static let swampy1 = "749da1"
    
    static let midnightGrey1 = "424c51"
}

extension Colors {
    
    var lavender1: UIColor {
        return UIColor(hex: Colors.lavender1)
    }
    
    var minty1: UIColor {
        return UIColor(hex: Colors.minty1)
    }
    
    var green1: UIColor {
        return UIColor(hex: Colors.green1)
    }
    
    var swampy1: UIColor {
        return UIColor(hex: Colors.swampy1)
    }
    
    var midnightGrey1: UIColor {
        return UIColor(hex: Colors.midnightGrey1)
    }
}
