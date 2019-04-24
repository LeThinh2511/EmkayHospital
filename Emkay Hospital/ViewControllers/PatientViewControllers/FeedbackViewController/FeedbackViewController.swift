//
//  FeedbackViewController.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 4/9/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import UIKit
import DropDown

class FeedbackViewController: BaseViewController {
    @IBOutlet weak var feedbackTextView: UITextView!
    @IBOutlet weak var dropdownContainer: UIView!
    @IBOutlet weak var selectSpecialistButton: UIButton!
    
    let dropdown = DropDown()
    
    var specialists = [Specialist]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.beginLoading()
        Service.sharedInstance.getSpecialistList(failure: { [weak self] (message) in
            self?.showAlert(title: Strings.alertTitle, message: message)
            self?.endLoading()
        }) { [weak self] (specialists) in
            self?.endLoading()
            var dataSource = [String]()
            self?.specialists = specialists
            specialists.forEach({ (specialist) in
                dataSource.append(specialist.specialistName ?? "")
            })
            self?.dropdown.dataSource = dataSource
        }
    }
    
    @IBAction func didTapSendButton(_ sender: Any) {
        guard let feedback = self.feedbackTextView.text, feedback.count > Constant.feedbackMinLength else {
            self.showAlert(title: Strings.alertTitle, message: Messages.feedbackNotLongEnough)
            return
        }
        guard let index = self.dropdown.indexForSelectedRow, let idSpecialist = self.specialists[index].id else { return }
        self.beginLoading()
        Service.sharedInstance.sendFeedback(feedback: feedback, idSpecialist: idSpecialist, failure: { [weak self] (message) in
            self?.showAlert(title: Strings.alertTitle, message: message)
            self?.endLoading()
        }) { [weak self] () in
            self?.showAlert(title: Strings.alertTitle, message: Messages.sendFeedbackSuccess)
            self?.feedbackTextView.text = nil
            self?.endLoading()
        }
    }
    
    @IBAction func didTapSelectSpecialistButton(_ sender: Any) {
        self.dropdown.show()
    }
    
    override func setupUI() {
        super.setupUI()
        self.dropdown.anchorView = self.dropdownContainer
        self.dropdown.direction = .bottom
        self.dropdown.backgroundColor = Constant.Color.darkGreen
        self.dropdown.selectionBackgroundColor = Constant.Color.lightGreen
        self.dropdown.textColor = UIColor.white
        self.dropdown.cornerRadius = 5
        self.dropdown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.selectSpecialistButton.setTitle(item, for: .normal)
        }
    }
}
