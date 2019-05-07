//
//  WorkdayCell.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 5/7/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import UIKit
import JTAppleCalendar

class WorkdayCell: JTAppleCell {
    @IBOutlet weak var selectedView: UIView!
    @IBOutlet weak var workdayView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    
    var isWorkday = false
}
