//
//  UIViewController+.swift
//  NewsApp
//
//  Created by user on 17.10.2021.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(title: String?, message: String?, style: UIAlertController.Style = .alert, titleButton: String = "OK", titleButtonStyle: UIAlertAction.Style = .default, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        let action = UIAlertAction(title: titleButton, style: titleButtonStyle, handler: handler)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
