//
//  BaseViewController.swift
//  Emkay Hospital
//
//  Created by ThinhLe on 3/30/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class BaseViewController: UIViewController {
    private var activityIndicator: NVActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func beginLoading() {
        if self.activityIndicator.isAnimating {
            return
        }
        self.activityIndicator.startAnimating()
        self.view.isUserInteractionEnabled = false
    }
    
    func endLoading() {
        if !self.activityIndicator.isAnimating {
            return
        }
        self.activityIndicator.stopAnimating()
        self.view.isUserInteractionEnabled = true
    }
    
    func setupUI() {
        let type = Constant.ActivityIndicator.type
        let color = Constant.ActivityIndicator.color
        let size = Constant.ActivityIndicator.size
        self.activityIndicator = NVActivityIndicatorView(frame: CGRect.zero, type: type, color: color, padding: nil)
        self.activityIndicator.addToCenter(of: self.view, with: size)
    }
}
