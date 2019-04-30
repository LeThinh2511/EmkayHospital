//
//  SingleAttributeTableViewCell.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 4/27/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import UIKit

class SingleAttributeTableViewCell: BaseTableViewCell {
    @IBOutlet weak var contentLabel: UILabel!
    
    var singleAttribute: Attribute! {
        didSet {
            guard self.singleAttribute.level == 0 else {
                print("Error: Not single attribute")
                return
            }
            self.contentLabel.text = self.singleAttribute.value ?? Strings.emptyAttribute
        }
    }
}
