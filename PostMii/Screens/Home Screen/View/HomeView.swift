//
//  HomeView.swift
//  PostMii
//
//  Created by Daniel Romero on 2023-09-05.
//

import Foundation
import UIKit
import Koloda

class HomeView: UIView {
    
    // MARK: - Variables
    
    // MARK: - Views
    
    private(set) var calendarView: HomeCalendarView = {
        let view = HomeCalendarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        return view
    }()
    
    private(set) var kolodaView: KolodaView = {
        let kolodaView = KolodaView()
        kolodaView.translatesAutoresizingMaskIntoConstraints = false
        return kolodaView
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setupViews() {
        backgroundColor = .systemGray6
        
        addSubview(calendarView)
        addSubview(kolodaView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            calendarView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            calendarView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            calendarView.heightAnchor.constraint(equalToConstant: 100),
            
            kolodaView.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 16),
            kolodaView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            kolodaView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            kolodaView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5)
        ])
    }
}
