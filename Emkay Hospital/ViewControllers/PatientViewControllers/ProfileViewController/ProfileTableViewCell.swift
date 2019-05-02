//
//  ProfileTableViewCell.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 4/23/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import UIKit

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
    
    @IBAction func didTapSelectAccountButton(_ sender: Any) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let rootViewController = appDelegate.window?.rootViewController
        rootViewController?.presentedViewController?.dismiss(animated: true, completion: nil)
    }
}
