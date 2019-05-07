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
        self.beginLoading()
        guard let userName = self.userNameTextField.text, let password = self.passwordTextField.text else {
            self.showAlert(title: Strings.alertTitle, message: Messages.missingUserNameOrPassword)
            self.endLoading()
            return
        }
        if userName.isEmpty || password.isEmpty {
            self.showAlert(title: Strings.alertTitle, message: Messages.missingUserNameOrPassword)
            self.endLoading()
            return
        }
        self.service.login(userName: userName, password: password, failure: { [weak self] (message) in
            self?.endLoading()
            self?.showAlert(title: Strings.alertTitle, message: message)
        }) { [weak self] (roleInt) in
            let role = Role(rawValue: roleInt) ?? .unknown
            switch role {
            case .patient, .doctor, .receipt:
                self?.service.sendDeviceID(failure: { (message) in
                    self?.endLoading()
                    self?.showAlert(title: Strings.alertTitle, message: message)
                }, success: {
                    self?.endLoading()
                    var key = UserDefaultKey.isNotFirstLaunch
                    UserDefaults.standard.set(true, forKey: key)
                    key = UserDefaultKey.isDoctor
                    UserDefaults.standard.set(role == .doctor, forKey: key)
                    let storyboardName = UIStoryboard.patientStoryboard
                    let viewController: SelectPatientViewController = UIStoryboard.initViewController(in: storyboardName)
                    self?.present(viewController, animated: true, completion: nil)
                })
            case .unknown:
                self?.endLoading()
                self?.showAlert(title: Strings.alertTitle, message: Messages.wrongUserNameOrPassword)
            }
        }
    }
    
    @IBAction func resignKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
}

