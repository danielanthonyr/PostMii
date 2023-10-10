//
//  CircleImageView.swift
//  PostMii
//
//  Created by Daniel Romero on 2023-10-09.
//

import UIKit

@IBDesignable
class CircleImageView: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = frame.size.width / 2
        clipsToBounds = true
    }
    
}
