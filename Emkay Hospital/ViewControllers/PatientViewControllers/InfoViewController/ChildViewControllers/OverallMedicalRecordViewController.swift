//
//  OverallMedicalRecordViewController.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 4/27/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import UIKit

class OverallMedicalRecordViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let service = Service.sharedInstance
    var examinations = [Examination]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.beginLoading()
        self.service.getExaminationList(failure: { [weak self] (message) in
            self?.endLoading()
            self?.showAlert(title: Strings.alertTitle, message: message)
        }) { [weak self] (examinations) in
            self?.endLoading()
            self?.examinations = examinations
            self?.tableView.reloadData()
        }
        self.setupTableView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case UIStoryboardSegue.overallMedicalRecordToExamination:
            let examinationViewController = segue.destination as! ExaminationViewController
            guard let indexPath = self.tableView.indexPathForSelectedRow else {
                assertionFailure()
                return
            }
            self.tableView.deselectRow(at: indexPath, animated: true)
            examinationViewController.examination = self.examinations[indexPath.row]
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

extension OverallMedicalRecordViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.examinations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = ExaminationTableViewCell.identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ExaminationTableViewCell
        cell.examination = self.examinations[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Strings.examinationList
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if self.examinations.isEmpty {
            return Strings.noExamination
        } else {
            return nil
        }
    }
}
