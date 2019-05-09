//
//  ExaminationRequestTableViewCell.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 5/2/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import UIKit

class ExaminationRequestTableViewCell: BaseTableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    var examinationRequest: ExaminationRequest! {
        didSet {
            self.dateLabel.text = self.examinationRequest.examinationTime?.dateString()
            self.statusLabel.text = self.examinationRequest.isProcessedTitle
        }
    }
}
