//
//  ExaminationViewController.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 4/30/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import UIKit

class ExaminationViewController: BaseViewController {
    @IBOutlet weak var examinationDateLabel: UILabel!
    @IBOutlet weak var diseaseInfoLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var simpleMedicalRecords = [SimpleMedicalRecord]()
    let service = Service.sharedInstance
    var examination: Examination!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.beginLoading()
        self.service.getSimpleMedicalRecordList(idExamination: self.examination.id, failure: { [weak self] (message) in
            self?.endLoading()
            self?.showAlert(title: Strings.alertTitle, message: message)
        }) { [weak self] (simpleMedicalRecords) in
            self?.endLoading()
            self?.simpleMedicalRecords = simpleMedicalRecords
            self?.tableView.reloadData()
        }
        self.setupTableView()
        self.examinationDateLabel.text = self.examination.date?.dateString()
        self.diseaseInfoLabel.text = self.examination.diseaseInfo
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case UIStoryboardSegue.examinationToMedicalRecord:
            let medicalRecordViewController = segue.destination as! MedicalRecordViewController
            guard let indexPath = self.tableView.indexPathForSelectedRow else {
                assertionFailure()
                return
            }
            self.tableView.deselectRow(at: indexPath, animated: true)
            medicalRecordViewController.medicalRecordID = self.simpleMedicalRecords[indexPath.row].id
        default:
            assertionFailure(UIStoryboardSegue.unreconizeIdentifier)
        }
    }
    
    private func setupTableView() {
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 100
        self.tableView.tableFooterView = UIView()
    }
}

extension ExaminationViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.simpleMedicalRecords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = MedicalRecordTableViewCell.identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MedicalRecordTableViewCell
        cell.simpleMedicalRecord = self.simpleMedicalRecords[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Strings.medicalRecordList
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if self.simpleMedicalRecords.isEmpty {
            return Strings.noMedicalRecord
        } else {
            return nil
        }
    }
}
