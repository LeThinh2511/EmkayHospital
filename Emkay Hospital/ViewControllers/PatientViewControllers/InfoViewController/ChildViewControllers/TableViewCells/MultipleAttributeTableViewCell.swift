//
//  MultipleAttributeTableViewCell.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 4/27/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import UIKit

class MultipleAttributeTableViewCell: BaseTableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    var multipleAttribute: Attribute! {
        didSet {
            let level = self.multipleAttribute.level
            self.titleLabel.text = self.multipleAttribute.name
            switch level {
            case 0:
                self.showAttributeLevel0()
            case 1:
                self.showAttributeLevel1()
            case 2:
                self.showAttributeLevel2()
            default:
                print("Error: Not support showing attribute level than 2.")
            }
        }
    }
    
    private func showAttributeLevel0() {
        self.stackView.removeAllSubviews()
        let contentLabel = UILabel()
        contentLabel.text = self.multipleAttribute.value
        self.stackView.addArrangedSubview(contentLabel)
    }
    
    private func showAttributeLevel1() {
        self.stackView.removeAllSubviews()
        guard let attributes = self.multipleAttribute.attributes else {
            return
        }
        for attribute in attributes {
            let singleAttributeView: SingleAttributeView = UIView.initFromNib()
            singleAttributeView.attribute = attribute
            self.stackView.addArrangedSubview(singleAttributeView)
        }
    }
    
    private func showAttributeLevel2() {
        self.stackView.removeAllSubviews()
        guard let attributes = self.multipleAttribute.attributes else {
            return
        }
        for attribute in attributes {
            if attribute.level == 0 {
                let singleAttributeView: SingleAttributeView = UIView.initFromNib()
                singleAttributeView.attribute = attribute
                self.stackView.addArrangedSubview(singleAttributeView)
            } else if attribute.level == 1 {
                guard let childAttributes = attribute.attributes else {
                    return
                }
                var value = ""
                for childAttribute in childAttributes {
                    value += "\n +\(childAttribute.name ?? Strings.emptyAttribute): \(childAttribute.value ?? Strings.emptyAttribute)"
                }
                let newAttribue = Attribute(name: attribute.name, key: "", isArray: false)
                newAttribue.value = value
                let singleAttributeView: SingleAttributeView = UIView.initFromNib()
                singleAttributeView.attribute = newAttribue
                self.stackView.addArrangedSubview(singleAttributeView)
            }
        }
        self.stackView.layoutIfNeeded()
        self.stackView.layoutSubviews()
        self.stackView.layoutIfNeeded()
    }
}
