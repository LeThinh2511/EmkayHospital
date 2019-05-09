//
//  ExaminationTableViewCell.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 4/30/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import UIKit

class ExaminationTableViewCell: BaseTableViewCell {
    @IBOutlet weak var examinationDateLabel: UILabel!
    @IBOutlet weak var diseaseInfoLabel: UILabel!
    
    var examination: Examination! {
        didSet {
            self.examinationDateLabel.text = self.examination.date?.dateString()
            self.diseaseInfoLabel.text = self.examination.diseaseInfo
        }
    }
}
