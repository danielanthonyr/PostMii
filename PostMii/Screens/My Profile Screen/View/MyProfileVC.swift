//
//  MyProfileVC.swift
//  PostMii
//
//  Created by Daniel Romero on 2023-09-25.
//

import Foundation
import UIKit

class MyProfileVC: UIViewController {
    
    // MARK: - Variables
    
    private let views = MyProfileView()
    private let viewModel = MyProfileVM()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = views
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSelf()
        setupViewModel()
    }
    
    // MARK: - Methods
    
    private func setupSelf() {
        self.title = "My Profile"
    }
    
    private func setupViewModel() {
        
    }
}
