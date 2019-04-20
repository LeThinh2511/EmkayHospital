//
//  ProfileViewController.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 4/9/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {
    var patient: Patient!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.beginLoading()
        Service.sharedInstance.getPatientInfo(failure: { [weak self] (message) in
            self?.endLoading()
            self?.showAlert(title: Strings.alertTitle, message: message)
        }) { [weak self] (patient) in
            self?.patient = patient
            dump(patient)
            self?.endLoading()
        }
    }
}
