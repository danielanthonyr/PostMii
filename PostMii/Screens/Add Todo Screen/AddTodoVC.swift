//
//  AddTodoVC.swift
//  PostMii
//
//  Created by Daniel Romero on 2023-09-05.
//

import Foundation
import UIKit

class AddTodoVC: UIViewController {
    
    // MARK: - Variables
    
    private let views = AddTodoView()
    private let viewModel = AddTodoVM()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = views
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSelf()
    }
    
    func setupSelf() {
        self.title = "PostMii"
    }
    
    // MARK: - Methods
    
}
