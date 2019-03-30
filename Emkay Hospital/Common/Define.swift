//
//  Define.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 3/30/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

struct Constant {
    struct ActivityIndicator {
        static let size: CGSize = {
            let width = System.ScreenSize.width / 3
            let height = width
            return CGSize(width: width, height: height)
        }()
        
        static let type = NVActivityIndicatorType.circleStrokeSpin
        static let color: UIColor? = UIColor.red
    }
}

struct System {
    struct ScreenSize {
        static let height = UIScreen.main.bounds.height
        static let width = UIScreen.main.bounds.width
    }
}
