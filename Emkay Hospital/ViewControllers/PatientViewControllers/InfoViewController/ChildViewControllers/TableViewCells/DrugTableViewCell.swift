//
//  DrugTableViewCell.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 5/2/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import UIKit

class DrugTableViewCell: BaseTableViewCell {
    @IBOutlet weak var drugNameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    
    var drug: Drug! {
        didSet {
            self.drugNameLabel.text = self.drug.drugName
            self.numberLabel.text = self.drug.number
            self.unitLabel.text = self.drug.unit
            self.noteLabel.text = self.drug.note
        }
    }
}
