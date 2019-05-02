//
//  PrescriptionViewController.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 5/2/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import UIKit

class PrescriptionViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var drugs = [Drug]()
    let service = Service.sharedInstance
    var idMedicalRecord: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.service.getPrescription(idMedicalRecord: self.idMedicalRecord, failure: { [weak self] (message) in
            self?.endLoading()
            self?.showAlert(title: Strings.alertTitle, message: message)
        }) { [weak self] (drugs) in
            self?.drugs = drugs
            self?.endLoading()
            self?.tableView.reloadData()
        }
        self.setupTableView()
    }
    
    private func setupTableView() {
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 100
        self.tableView.tableFooterView = UIView()
    }
}

extension PrescriptionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.drugs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = DrugTableViewCell.identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! DrugTableViewCell
        cell.drug = self.drugs[indexPath.row]
        return cell
    }
}
