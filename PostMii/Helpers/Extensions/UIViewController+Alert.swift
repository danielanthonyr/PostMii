//
//  UIViewController+Alert.swift
//  PostMii
//
//  Created by Daniel Romero on 2023-09-27.
//

import Foundation
import UIKit

extension UIViewController {
    
    func displayAlertMessage(title: String, message: String) {
        let alertMessage = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title:"OK", style: .default, handler:nil)
        
        alertMessage.addAction(okAction)
        
        self.present(alertMessage, animated: true, completion: nil)
    }
    
}
