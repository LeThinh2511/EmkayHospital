//
//  UIViewExtension.swift
//  Emkay Hospital
//
//  Created by ThinhLe on 3/30/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import UIKit

extension UIView {
    static var identifier: String {
        return String(describing: self)
    }
    
    func removeAllSubviews() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
    
    func add(to view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        self.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    func addToCenter(of view: UIView, with size: CGSize) {
        self.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        self.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        self.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        self.layoutIfNeeded()
    }
    
    static func initFromNib<T: UIView>() -> T {
        let view = Bundle.main.loadNibNamed(T.identifier, owner: self, options: nil)?.first as? T
        if let view = view {
            return view
        } else {
            fatalError("There is no nib file name: \(T.identifier)")
        }
    }
}
