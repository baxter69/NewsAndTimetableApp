//
//  LoginViewController.swift
//  NewsApp
//
//  Created by user on 17.10.2021.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    @IBOutlet private var loginLabel: UILabel!
    @IBOutlet private var loginTextField: UITextField!
    @IBOutlet private var passwordLabel: UILabel!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var passwordButton: UIButton!
    
    @IBAction func changePasswordVisibility(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry.toggle()
        if passwordTextField.isSecureTextEntry {
            if let image = UIImage(systemName: "eye.fill") {
                sender.setImage(image, for: .normal)
            }
        } else {
            if let image = UIImage(systemName: "eye.slash.fill") {
                sender.setImage(image, for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginTextField.text = "admin"
        passwordTextField.text = "password123456"
        //passwordTextField.im
        // Do any additional setup after loading the view.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "tapButtonLoginSegue" {
            let login = loginTextField.text
            let password = passwordTextField.text
            if login == "admin" && password == "password123456" {
                return true
            } else if login == "" && password != "" {
                showAlert(title: "Ошибка", message: "Не введено имя пользователя", style: .actionSheet, titleButtonStyle: .default)
                return false
            } else if login != "" && password == "" {
                showAlert(title: "Ошибка", message: "Не был введен пароль", style: .actionSheet, titleButtonStyle: .default)
                return false
            } else if login == "" && password == "" {
                showAlert(title: "Ошибка", message: "Не введены имя пользователя и пароль для входа", style: .actionSheet, titleButtonStyle: .default)
                return false
            } else {
                showAlert(title: "Ошибка", message: "Введены неверные данные пользователя", style: .actionSheet, titleButtonStyle: .default)
                return false
            }
        }
        print("переход\(identifier)")
        return true
    }
}
