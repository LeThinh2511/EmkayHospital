//
//  UIStoryboardExtension.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 4/9/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import UIKit

extension UIStoryboard {
    static let mainStoryboard = "Main"
    static let patientStoryboard = "Patient"
    static let doctorStoryboard = "Doctor"
    
    static func initViewController<T: UIViewController>(in storyboardName: String) -> T {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let identifier = String(describing: T.self)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
            fatalError("Storyboard \(storyboardName) doesn't contain a view controller with identifier \(identifier)")
        }
        return viewController
    }
}
