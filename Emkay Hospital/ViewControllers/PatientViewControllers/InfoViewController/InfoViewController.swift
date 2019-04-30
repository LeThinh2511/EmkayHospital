//
//  InfoViewController.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 4/9/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import UIKit

class InfoViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNeedsStatusBarAppearanceUpdate()
        self.navigationController?.navigationBar.barStyle = .black
    }
    
    @IBAction func didTapButton(_ sender: Any) {
        let storyboardName = UIStoryboard.patientStoryboard
        let viewController: MedicalRecordViewController = UIStoryboard.initViewController(in: storyboardName)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
