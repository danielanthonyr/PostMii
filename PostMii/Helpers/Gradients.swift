//
//  Gradients.swift
//  PostMii
//
//  Created by Daniel Romero on 2023-09-06.
//

import Foundation
import UIKit

struct Gradients {
    lazy var pinkOrangeGradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = [
            UIColor.systemPink.cgColor,
            UIColor.systemOrange.cgColor,
        ]
        gradient.startPoint = .init(x: 0, y: 0) // top left
        gradient.endPoint = .init(x: 1, y: 1) // bottom right
        return gradient
    }()
    
    lazy var pinkBeigeGradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = [
            UIColor.TodoCardTheme.pink300.cgColor,
            UIColor.TodoCardTheme.pink100.cgColor,
        ]
        gradient.startPoint = .init(x: 0, y: 0) // top left
        gradient.endPoint = .init(x: 1, y: 1) // bottom right
        return gradient
    }()
    
    lazy var mintyGradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = [
            UIColor.TodoCardTheme.mint200.cgColor,
            UIColor.TodoCardTheme.mint100.cgColor,
        ]
        gradient.startPoint = .init(x: 0, y: 0) // top left
        gradient.endPoint = .init(x: 1, y: 1) // bottom right
        return gradient
    }()
    
    var allGradients = [CAGradientLayer]()
    
    init() {
        allGradients = [pinkOrangeGradient, pinkBeigeGradient, mintyGradient]
    }
}

extension UIColor {
    struct TodoCardTheme {
        // PINK
        static let pink100 = UIColor(hex: "#fed1c7")
        static let pink300 = UIColor(hex: "#fe8dc6")
        
        // MINT
        static let mint100 = UIColor(hex: "#C1FCD3")
        static let mint200 = UIColor(hex: "#0CCDA3")
        
        // BLUEPURPLE
        static let bluepurple100 = UIColor(hex: "#AEBAF8")
        static let bluepurple200 = UIColor(hex: "#C973FF")
        
        // LIGHTBLUE - BLUE
        static let lightBlue100 = UIColor(hex: "#A3C9E2")
        static let lightBlue500 = UIColor(hex: "#9618F7")
        
        // PURPLE
        static let purple100 = UIColor(hex: "#E5AAC3")
        static let purple200 = UIColor(hex: "#9A52C7")
    }
}
