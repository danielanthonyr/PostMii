//
//  TabBarController.swift
//  PostMii
//
//  Created by Daniel Romero on 2023-09-25.
//

import Foundation
import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    // MARK: - Variables
    
    var userUID: String!
    
    // MARK: - Lifycycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Creating tabs & their controllers
        let homeTab = UINavigationController(rootViewController: HomeVC())
        let homeTabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        
        homeTab.tabBarItem = homeTabBarItem
        
        let profileTab = UINavigationController(rootViewController: MyProfileVC())
        let myProfileTabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill")
        )
        
        profileTab.tabBarItem = myProfileTabBarItem
        
        let notificationsTab = UINavigationController(rootViewController: NotificationsVC())
        let notificationsTabBarItem = UITabBarItem(
            title: "Notifications",
            image: UIImage(systemName: "bell.badge"),
            selectedImage: UIImage(systemName: "bell.badge.fill")
        )
        
        notificationsTab.tabBarItem = notificationsTabBarItem
        
        self.viewControllers = [homeTab, profileTab, notificationsTab]
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected \(viewController.title)")
    }
}
