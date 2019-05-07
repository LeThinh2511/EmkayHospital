//
//  ReexaminationTableViewCell.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 5/1/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import UIKit

class ReexaminationTableViewCell: BaseTableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var doctorNameLabel: UILabel!
    @IBOutlet weak var roomLabel: UILabel!
    @IBOutlet weak var shiftLabel: UILabel!
    
    var reexamination: Reexamination! {
        didSet {
            self.dateLabel.text = self.reexamination.date
            self.doctorNameLabel.text = self.reexamination.doctorName
            self.roomLabel.text = "\(self.reexamination.roomName ?? "") - \(self.reexamination.roomNumber ?? "")"
            self.shiftLabel.text = self.reexamination.getShiftTitle()
        }
    }
}
