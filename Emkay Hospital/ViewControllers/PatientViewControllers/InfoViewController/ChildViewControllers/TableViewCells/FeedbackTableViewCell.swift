//
//  FeedbackTableViewCell.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 5/8/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import UIKit

class FeedbackTableViewCell: BaseTableViewCell {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    var feedback: Feedback! {
        didSet {
            self.timeLabel.text = self.feedback.time
            self.contentLabel.text = self.feedback.content
        }
    }
}
