//
//  ShowFeedbackViewController.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 5/8/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import UIKit

class ShowFeedbackViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var feedbacks = [Feedback]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.beginLoading()
        Service.sharedInstance.getFeedbackList(failure: { [weak self] (message) in
            self?.endLoading()
            self?.showAlert(title: Strings.alertTitle, message: message)
        }) { [weak self] (feedbacks) in
            self?.endLoading()
            self?.feedbacks = feedbacks
            self?.tableView.reloadData()
        }
        self.setupTableView()
    }
    
    func setupTableView() {
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 100
        self.tableView.tableFooterView = UIView()
    }
}

extension ShowFeedbackViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.feedbacks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = FeedbackTableViewCell.identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! FeedbackTableViewCell
        cell.feedback = self.feedbacks[indexPath.row]
        return cell
    }
}
