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
    @IBOutlet weak var tableView: UITableView!
    
    var dateFormater: DateFormatter = {
        var dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        return dateFormater
    }()
    
    var examinationRequests = [ExaminationRequest]()
    let service = Service.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let minDate = Date()
        self.datePicker.minimumDate = minDate
        self.getExaminationRequestList()
        self.setupTableView()
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
            self?.getExaminationRequestList()
            self?.showAlert(title: Strings.alertTitle, message: Messages.scheduleExaminationRequestSent)
        }
    }
    
    override func dismissKeyboard() {
        super.dismissKeyboard()
        self.datePickerContainer.isHidden = true
    }
    
    private func getExaminationRequestList() {
        self.beginLoading()
        self.service.getExaminationRequestList(failure: { [weak self] (message) in
            self?.endLoading()
            self?.showAlert(title: Strings.alertTitle, message: message)
        }) { [weak self] (examinationRequests) in
            self?.endLoading()
            self?.examinationRequests = examinationRequests
            self?.tableView.reloadData()
        }
    }
    
    private func setupTableView() {
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 100
        self.tableView.tableFooterView = UIView()
    }
}

extension ScheduleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.examinationRequests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = ExaminationRequestTableViewCell.identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ExaminationRequestTableViewCell
        cell.examinationRequest = self.examinationRequests[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Strings.examinationRequests
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if self.examinationRequests.isEmpty {
            return Strings.noExaminationRequest
        }
        return ""
    }
}
