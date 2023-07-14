//
//  UIAlertController+Extension.swift
//  CarCatalogueApp
//
//  Created by Abigail Mariano on 7/14/23.
//

import Foundation
import UIKit

extension UIAlertController {
    static func showAlert(title: String, message: String, on viewController: UIViewController, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        }
        alert.addAction(okAction)
        
        viewController.present(alert, animated: true, completion: nil)
    }
}
