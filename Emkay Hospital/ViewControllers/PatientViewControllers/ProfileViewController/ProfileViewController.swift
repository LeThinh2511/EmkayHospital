//
//  ProfileViewController.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 4/9/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var patient: Patient!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.beginLoading()
        Service.sharedInstance.getPatientInfo(failure: { [weak self] (message) in
            self?.endLoading()
            self?.showAlert(title: Strings.alertTitle, message: message)
        }) { [weak self] (patient) in
            self?.patient = patient
            self?.endLoading()
            self?.tableView.reloadData()
        }
        self.setupTableView()
    }
    
    private func setupTableView() {
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableView.automaticDimension
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.patient == nil ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = ProfileTableViewCell.identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ProfileTableViewCell
        cell.patient = self.patient
        cell.viewController = self
        return cell
    }
}
