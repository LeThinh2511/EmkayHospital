//
//  MedicalRecordTableViewCell.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 4/30/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import UIKit

class MedicalRecordTableViewCell: BaseTableViewCell {
    @IBOutlet weak var specialistLabel: UILabel!
    
    var simpleMedicalRecord: SimpleMedicalRecord! {
        didSet {
            self.specialistLabel.text = self.simpleMedicalRecord.roomName
        }
    }
}
