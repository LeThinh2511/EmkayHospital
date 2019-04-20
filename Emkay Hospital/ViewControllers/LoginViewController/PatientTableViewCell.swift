//
//  PatientTableViewCell.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 4/20/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import UIKit

class PatientTableViewCell: BaseTableViewCell {
    @IBOutlet weak var userNameLabel: UILabel!
    
    var patient: Patient! {
        didSet {
            self.userNameLabel.text = self.patient.name
        }
    }
}
