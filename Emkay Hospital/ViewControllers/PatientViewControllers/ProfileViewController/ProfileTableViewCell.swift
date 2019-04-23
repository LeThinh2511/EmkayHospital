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
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var patient: Patient! {
        didSet {
            self.nameLabel.text = self.patient.name
            self.birthdayLabel.text = self.patient.birthday
            self.genderLabel.text = self.patient.gender?.title
            self.phoneLabel.text = self.patient.phone
            self.addressLabel.text = self.patient.address
        }
    }
    
    @IBAction func didTapSelectAccountButton(_ sender: Any) {
        guard let viewController = self.viewController else { return }
        let storyboardName = UIStoryboard.patientStoryboard
        let selectPatientViewController: SelectPatientViewController = UIStoryboard.initViewController(in: storyboardName)
        viewController.present(selectPatientViewController, animated: true, completion: nil)
    }
}
