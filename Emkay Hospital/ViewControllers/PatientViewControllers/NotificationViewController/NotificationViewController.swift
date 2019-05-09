//
//  NotificationViewController.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 4/9/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import UIKit

class NotificationViewController: BaseViewController {
    @IBOutlet weak var examinationSoonContainerView: UIView!
    @IBOutlet weak var examinationSoonLabel: UILabel!
    @IBOutlet weak var examinationNowContainerView: UIView!
    @IBOutlet weak var remainWaitingPeopleLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var roomLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchStatus()
    }
    
    @IBAction func didTapUpdateStatus(_ sender: Any) {
        self.fetchStatus()
    }
    
    private func fetchStatus() {
        self.beginLoading()
        Service.sharedInstance.getStatus(failure: { [weak self] (message) in
            self?.endLoading()
            self?.showAlert(title: Strings.alertTitle, message: message)
        }) { [weak self] (status) in
            self?.endLoading()
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "dd-MM-yyyy"
            let today = dateFormater.string(from: Date())
            guard let date = status.date, date.dateString() == today else {
                self?.examinationSoonContainerView.isHidden = false
                self?.examinationSoonLabel.text = Strings.noExamination
                self?.examinationNowContainerView.isHidden = true
                return
            }
        }
    }
}
