//
//  ProfileTableViewCell.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 4/23/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import UIKit
import DropDown

class ProfileTableViewCell: BaseTableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var maleRadioButton: UIButton!
    @IBOutlet weak var femaleRadioButton: UIButton!
    @IBOutlet weak var editBirthdayButton: UIButton!
    @IBOutlet weak var birthdayTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var datePickerContainerView: UIView!
    @IBOutlet weak var dropdownView: UIView!
    
    var dropdown = DropDown()
    var changePasswordAlert: UIAlertController?
    
    var patient: Patient! {
        didSet {
            self.nameLabel.text = self.patient.name
            self.birthdayTextField.text = self.patient.birthday
            self.phoneTextField.text = self.patient.phone
            self.addressTextField.text = self.patient.address
            self.isMale = self.patient.gender ?? .unknown == .male
        }
    }
    
    var isEditMode = false {
        didSet {
            if self.isEditMode {
                self.birthdayTrailingConstraint.priority = UILayoutPriority(rawValue: 500)
                self.maleRadioButton.isUserInteractionEnabled = true
                self.femaleRadioButton.isUserInteractionEnabled = true
                self.phoneTextField.isUserInteractionEnabled = true
                self.addressTextField.isUserInteractionEnabled = true
            } else {
                self.birthdayTrailingConstraint.priority = UILayoutPriority(rawValue: 900)
                self.maleRadioButton.isUserInteractionEnabled = false
                self.femaleRadioButton.isUserInteractionEnabled = false
                self.phoneTextField.isUserInteractionEnabled = false
                self.addressTextField.isUserInteractionEnabled = false
                self.datePickerContainerView.isHidden = true
            }
        }
    }
    
    var isMale = false {
        didSet {
            let radioButtonSelected = #imageLiteral(resourceName: "radioButtonSelected")
            let radioButtonDeselected = #imageLiteral(resourceName: "radioButtonDeselected")
            if self.isMale {
                self.maleRadioButton.setBackgroundImage(radioButtonSelected, for: .normal)
                self.femaleRadioButton.setBackgroundImage(radioButtonDeselected, for: .normal)
            } else {
                self.maleRadioButton.setBackgroundImage(radioButtonDeselected, for: .normal)
                self.femaleRadioButton.setBackgroundImage(radioButtonSelected, for: .normal)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.dropdown.anchorView = self.dropdownView
        self.dropdown.direction = .bottom
        self.dropdown.backgroundColor = Constant.Color.darkGreen
        self.dropdown.selectionBackgroundColor = Constant.Color.darkGreen
        self.dropdown.textColor = UIColor.white
        self.dropdown.cornerRadius = 5
        self.dropdown.dataSource = [Strings.logout, Strings.changePasword, Strings.changeAccount]
        self.dropdown.selectionAction = { [weak self] (index: Int, item: String) in
            switch item {
            case Strings.logout:
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                    return
                }
                var key = UserDefaultKey.accessToken
                UserDefaults.standard.set("", forKey: key)
                key = UserDefaultKey.idPatient
                UserDefaults.standard.set("", forKey: key)
                key = UserDefaultKey.isNotFirstLaunch
                UserDefaults.standard.set(false, forKey: key)
                let rootViewController = appDelegate.window?.rootViewController
                rootViewController?.dismiss(animated: true, completion: nil)
            case Strings.changePasword:
                guard let viewController = self?.viewController as? BaseViewController else {
                    return
                }
                let changePasswordAlert = UIAlertController(title: Strings.changePasword, message: nil, preferredStyle: .alert)
                changePasswordAlert.addTextField(configurationHandler: { (textField) in
                    textField.placeholder = Strings.oldPassword
                    textField.isSecureTextEntry = true
                })
                changePasswordAlert.addTextField(configurationHandler: { (textField) in
                    textField.placeholder = Strings.newPassword
                    textField.isSecureTextEntry = true
                })
                changePasswordAlert.addTextField(configurationHandler: { (textField) in
                    textField.placeholder = Strings.confirmPassword
                    textField.isSecureTextEntry = true
                })
                let cancelAction = UIAlertAction(title: Strings.cancel, style: .cancel, handler: nil)
                changePasswordAlert.addAction(cancelAction)
                let okAction = UIAlertAction(title: Strings.ok, style: .default, handler: { (okAction) in
                    let oldPassword = changePasswordAlert.textFields?[0].text ?? ""
                    let newPassword = changePasswordAlert.textFields?[1].text ?? ""
                    let confirmPassword = changePasswordAlert.textFields?[2].text ?? ""
                    if newPassword != confirmPassword {
                        viewController.showAlert(title: Strings.alertTitle, message: Messages.newPasswordNotMatch)
                        return
                    }
                    viewController.beginLoading()
                    Service.sharedInstance.updatePassword(oldPassword: oldPassword, newPassword: newPassword, failure: { (message) in
                        viewController.showAlert(title: Strings.alertTitle, message: message)
                        viewController.endLoading()
                    }, success: {
                        viewController.endLoading()
                        viewController.showAlert(title: Strings.alertTitle, message: Messages.updatePasswordSuccess)
                    })
                })
                changePasswordAlert.addAction(okAction)
                self?.changePasswordAlert = changePasswordAlert
                viewController.present(changePasswordAlert, animated: true, completion: nil)
            case Strings.changeAccount:
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                    return
                }
                let rootViewController = appDelegate.window?.rootViewController
                rootViewController?.presentedViewController?.dismiss(animated: true, completion: nil)
            default:
                break
            }
        }
    }
    
    @objc func changePasswordValidation() {
        guard let alert = self.changePasswordAlert else { return }
        let oldPassword = alert.textFields?[0].text ?? ""
        let newPassword = alert.textFields?[1].text ?? ""
        let confirmPassword = alert.textFields?[2].text ?? ""
        if oldPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty {
            alert.actions[1].isEnabled = false
        } else {
            alert.actions[1].isEnabled = true
        }
    }
    
    @IBAction func didTapEditBirthdayButton(_ sender: Any) {
        let dateString = self.birthdayTextField.text ?? ""
        guard let date = Date.date(from: dateString) else { return }
        self.datePicker.date = date
        self.datePickerContainerView.isHidden = !self.datePickerContainerView.isHidden
    }
    
    @IBAction func didTapMaleButton(_ sender: Any) {
        self.isMale = true
        self.patient.gender = .male
    }
    
    @IBAction func didTapFemaleButton(_ sender: Any) {
        self.isMale = false
        self.patient.gender = .female
    }
    
    @IBAction func didPickDate(_ sender: Any) {
        let date = self.datePicker.date
        self.birthdayTextField.text = date.dateString()
        self.datePickerContainerView.isHidden = true
        self.patient.birthday = date.dateString()
    }
    
    @IBAction func didTapAccountButton(_ sender: Any) {
        self.dropdown.show()
    }
}
