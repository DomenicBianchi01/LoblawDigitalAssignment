//
//  UIViewControllerExtensions.swift
//  LoblawDigitalAssignment
//
//  Created by Domenic Bianchi on 2020-04-02.
//  Copyright © 2020 Domenic Bianchi. All rights reserved.
//

import UIKit

// MARK: - UIViewController

extension UIViewController {
    
    /// Display a basic alert on the screen. Only an "OK" alert action will be included.
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
        alert.addAction(alertAction)
            
        self.present(alert, animated: true, completion: nil)
    }
}
