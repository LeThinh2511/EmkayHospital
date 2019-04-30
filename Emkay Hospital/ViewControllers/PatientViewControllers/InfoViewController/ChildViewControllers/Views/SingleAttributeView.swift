//
//  SingleAttributeView.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 4/27/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import UIKit

class SingleAttributeView: UIView {
    @IBOutlet weak var contentLabel: UILabel!
    
    var attribute: Attribute! {
        didSet {
            guard let title = self.attribute.name, let description = self.attribute.value else { return }
            let attributedText = NSMutableAttributedString(string: title + ": ", attributes: [NSAttributedString.Key.foregroundColor: Constant.Color.lightGreen, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
            attributedText.append(NSAttributedString(string: description, attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]))
            self.contentLabel.attributedText = attributedText
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.translatesAutoresizingMaskIntoConstraints = false
//        let heightConstraint = self.heightAnchor.constraint(equalToConstant: 100)
//        heightConstraint.priority = UILayoutPriority(rawValue: 200)
//        heightConstraint.isActive = true
    }
}
