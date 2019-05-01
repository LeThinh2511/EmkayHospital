//
//  ReexaminationViewController.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 5/1/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import UIKit

class ReexaminationViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var reexaminations = [Reexamination]()
    let service = Service.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.beginLoading()
        self.service.getReexaminationList(failure: { [weak self] (message) in
            self?.endLoading()
            self?.showAlert(title: Strings.alertTitle, message: message)
        }) { [weak self] (reexaminations) in
            self?.endLoading()
            self?.reexaminations = reexaminations
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

extension ReexaminationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reexaminations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = ReexaminationTableViewCell.identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ReexaminationTableViewCell
        cell.reexamination = self.reexaminations[indexPath.row]
        return cell
    }
}
