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
            if self.examination.isPaid == "0" {
                self.backgroundColor = UIColor(red: 201 / 255, green: 68 / 255, blue: 79 / 255, alpha: 1)
            } else {
                self.backgroundColor = UIColor(red: 73 / 255, green: 102 / 255, blue: 175 / 255, alpha: 1)
            }
        }
    }
}
