//
//  NotificationsVC.swift
//  PostMii
//
//  Created by Daniel Romero on 2023-09-25.
//

import Foundation
import UIKit

class NotificationsVC: UIViewController {
    
    // MARK: - Variables
    
    private let views = NotificationsView()
    private let viewModel = NotificationsVM()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = views
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSelf()
    }
    
    // MARK: - Methods
    
    private func setupSelf() {
        self.title = "Notifications"
    }
    
    private func setupViewModel() {
        
    }
}
