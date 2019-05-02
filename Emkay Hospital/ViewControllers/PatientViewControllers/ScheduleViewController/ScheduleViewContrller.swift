//
//  ScheduleViewContrller.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 4/9/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import UIKit

class ScheduleViewController: BaseViewController {
    @IBOutlet weak var datePickerContainer: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var selectDateButton: UIButton!
    
    var dateFormater: DateFormatter = {
        var dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        return dateFormater
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let minDate = Date()
        self.datePicker.minimumDate = minDate
    }
    
    @IBAction func didTapOKButton(_ sender: Any) {
        self.datePickerContainer.isHidden = true
        let date = self.datePicker.date
        let title = self.dateFormater.string(from: date)
        self.selectDateButton.setTitle(title, for: .normal)
    }
    
    @IBAction func didTapSelectDateButton(_ sender: Any) {
        self.datePickerContainer.isHidden = !self.datePickerContainer.isHidden
    }
    
    @IBAction func didTapSendButton(_ sender: Any) {
        let content = self.contentTextView.text ?? ""
        if content.isEmpty {
            self.showAlert(title: Strings.alertTitle, message: Messages.scheduleExaminationContentEmpty)
            return
        }
        let date = self.datePicker.date
        let dateString = self.dateFormater.string(from: date)
        self.beginLoading()
        Service.sharedInstance.scheduleExamination(content: content, date: dateString, failure: { [weak self] (message) in
            self?.endLoading()
            self?.showAlert(title: Strings.alertTitle, message: message)
        }) { [weak self] () in
            self?.endLoading()
            self?.showAlert(title: Strings.alertTitle, message: Messages.scheduleExaminationRequestSent)
        }
    }
}
