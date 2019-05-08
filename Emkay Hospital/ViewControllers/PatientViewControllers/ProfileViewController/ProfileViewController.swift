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
    @IBOutlet weak var editButtonTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    var patient: Patient!
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(fetchData), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = Constant.Color.darkGreen
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchData()
        self.setupTableView()
        self.tableView.addSubview(self.refreshControl)
    }
    
    @IBAction func didTapCancelButton(_ sender: UIButton) {
        self.editButtonTrailingConstraint.priority = UILayoutPriority(rawValue: 900)
        let indexPath = IndexPath(row: 0, section: 0)
        guard let cell = self.tableView.cellForRow(at: indexPath) as? ProfileTableViewCell else {
            return
        }
        sender.setTitle(Strings.edit, for: .normal)
        cell.isEditMode = false
        self.editButton.setTitle(Strings.edit, for: .normal)
    }
    
    @IBAction func didTapEditButton(_ sender: UIButton) {
        let indexPath = IndexPath(row: 0, section: 0)
        guard let cell = self.tableView.cellForRow(at: indexPath) as? ProfileTableViewCell, let action = self.editButton.titleLabel?.text else {
            return
        }
        if action == Strings.save {
            self.beginLoading()
            Service.sharedInstance.updatePatientInfo(patient: cell.patient, failure: { [weak self] (message) in
                self?.showAlert(title: Strings.alertTitle, message: Messages.updatePatientInfoFailure)
                self?.endLoading()
            }) { [weak self] () in
                self?.showAlert(title: Strings.alertTitle, message: Messages.updatePatientInfoSuccess)
                self?.endLoading()
            }
            self.editButton.setTitle(Strings.edit, for: .normal)
            self.editButtonTrailingConstraint.priority = UILayoutPriority(rawValue: 900)
        } else {
            self.editButtonTrailingConstraint.priority = UILayoutPriority(rawValue: 500)
            self.editButton.setTitle(Strings.save, for: .normal)
            self.cancelButton.setTitle(Strings.cancel, for: .normal)
        }
        cell.isEditMode = !cell.isEditMode
    }
    
    private func setupTableView() {
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableView.automaticDimension
    }
    
    @objc private func fetchData() {
        self.beginLoading()
        Service.sharedInstance.getPatientInfo(failure: { [weak self] (message) in
            self?.endLoading()
            self?.refreshControl.endRefreshing()
            self?.showAlert(title: Strings.alertTitle, message: message)
        }) { [weak self] (patient) in
            self?.patient = patient
            self?.endLoading()
            self?.refreshControl.endRefreshing()
            self?.tableView.reloadData()
        }
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
