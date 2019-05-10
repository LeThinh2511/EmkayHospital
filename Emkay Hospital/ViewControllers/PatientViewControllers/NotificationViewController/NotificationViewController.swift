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
            self?.examinationSoonContainerView.isHidden = false
            self?.examinationSoonLabel.text = Strings.noExamination
            self?.examinationNowContainerView.isHidden = true
        }) { [weak self] (status) in
            self?.endLoading()
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "dd-MM-yyyy"
            let today = dateFormater.string(from: Date())
            guard let date = status.date else {
                self?.examinationSoonContainerView.isHidden = false
                self?.examinationSoonLabel.text = Strings.noExamination
                self?.examinationNowContainerView.isHidden = true
                return
            }
            if date.dateString() == today {
                if let numOfPeople = status.remainWaitingPeople, numOfPeople == 0 {
                    self?.statusLabel.text = Strings.examinationInvite
                    self?.statusLabel.textColor = Constant.Color.darkGreen
                } else {
                    self?.statusLabel.text = Strings.pleaseWait
                    self?.statusLabel.textColor = UIColor.red
                }
                self?.examinationSoonContainerView.isHidden = true
                self?.remainWaitingPeopleLabel.text = "\(status.remainWaitingPeople ?? 0)"
                self?.roomLabel.text = "\(status.roomName ?? "") - \(status.roomNumber ?? "")"
                self?.examinationNowContainerView.isHidden = false
            } else {
                self?.examinationSoonContainerView.isHidden = false
                self?.examinationSoonLabel.text = String(format: Strings.examinationSoon, date.dateString(), "\(status.roomName ?? "") -  \(status.roomNumber ?? "")")
                self?.examinationNowContainerView.isHidden = true
            }
        }
    }
}
