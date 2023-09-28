//
//  AppFont.swift
//  PostMii
//
//  Created by Daniel Romero on 2023-09-27.
//

import Foundation
import UIKit

private let familyName = "OpenSans"

enum AppFont: String {
    case regular = "Regular"
    case medium = "Medium"
    case bold = "Bold"
    case semiBold = "Semi-Bold"

    func size(_ size: CGFloat) -> UIFont {
        if let font = UIFont(name: fullFontName, size: size + 1.0) {
            return font
        }
        fatalError("Font '\(fullFontName)' does not exist.")
    }
    fileprivate var fullFontName: String {
        return rawValue.isEmpty ? familyName : familyName + "-" + rawValue
    }
}
