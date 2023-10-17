//
//  TodoCardOverlayView.swift
//  PostMii
//
//  Created by Daniel Romero on 2023-10-17.
//

import Foundation
import Koloda
import UIKit

class TodoCardOverlayView: OverlayView {
    override var overlayState: SwipeResultDirection!  {
        didSet {
            switch overlayState {
            case .left :
                overlayImageView.image = UIImage(named: "x-refusal-mark")
            case .right :
                overlayImageView.image = UIImage(named: "green-check-mark")
            default:
                overlayImageView.image = nil
            }
        }
    }
    
    private(set) var overlayImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white
        return imageView
    }()
    
    init() {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(overlayImageView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            overlayImageView.topAnchor.constraint(equalTo: topAnchor),
            overlayImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            overlayImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            overlayImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
