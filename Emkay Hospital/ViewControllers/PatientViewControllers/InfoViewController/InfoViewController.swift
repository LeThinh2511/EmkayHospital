//
//  InfoViewController.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 4/9/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import UIKit

class InfoViewController: BaseViewController {
    @IBOutlet weak var workScheduleButton: UIButton!
    @IBOutlet weak var feedbackButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupUI() {
        super.setupUI()
        var key = UserDefaultKey.isDoctor
        let isDoctor = UserDefaults.standard.bool(forKey: key)
        if isDoctor {
            self.workScheduleButton.isHidden = false
            key = UserDefaultKey.isHeadDoctor
            let isHeadDoctor = UserDefaults.standard.bool(forKey: key)
            self.feedbackButton.isHidden = !isHeadDoctor
        } else {
            self.workScheduleButton.isHidden = true
            self.feedbackButton.isHidden = true
        }
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
