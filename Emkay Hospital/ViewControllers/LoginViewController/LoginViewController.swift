//
//  ViewController.swift
//  Emkay Hospital
//
//  Created by ThinhLe on 3/29/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    
    let service = Service.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapLoginButton(_ sender: Any) {
        guard let userName = self.userNameTextField.text, let password = self.passwordTextField.text else {
            self.showAlert(title: Strings.alertTitle, message: Messages.missingUserNameOrPassword)
            return
        }
        if userName.isEmpty || password.isEmpty {
            self.showAlert(title: Strings.alertTitle, message: Messages.missingUserNameOrPassword)
            return
        }
        self.service.login(userName: userName, password: password, failure: { [weak self] (message) in
            self?.showAlert(title: Strings.alertTitle, message: message)
        }) { [weak self] (role) in
            self?.showAlert(title: Strings.alertTitle, message: "Login success with role: \(role)")
        }
    }
    
    @IBAction func resignKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
}

