//
//  BaseViewController.swift
//  Emkay Hospital
//
//  Created by ThinhLe on 3/30/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import PMAlertController

class BaseViewController: UIViewController {
    private var activityIndicator: NVActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
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
    
    func showAlert(title: String, message: String) {
        let alertController = PMAlertController(title: title, description: message, image: nil, style: .alert)
        let action = PMAlertAction(title: "OK", style: .cancel)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func setupUI() {
        let type = Constant.ActivityIndicator.type
        let color = Constant.ActivityIndicator.color
        let size = Constant.ActivityIndicator.size
        self.activityIndicator = NVActivityIndicatorView(frame: CGRect.zero, type: type, color: color, padding: nil)
        self.activityIndicator.addToCenter(of: self.view, with: size)
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
}
