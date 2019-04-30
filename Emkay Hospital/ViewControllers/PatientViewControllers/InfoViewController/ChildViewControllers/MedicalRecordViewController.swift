//
//  MedicalRecordViewController.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 4/27/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import UIKit
import DropDown

class MedicalRecordViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dropdownContainerView: UIView!
    @IBOutlet weak var attributeSelectionButton: UIButton!
    
    var medicalRecord: MedicalRecord?
    var dropdown: DropDown!
    let service = Service.sharedInstance
    var medicalRecordID: String!
    var attributeIndexSelected: Int? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupDropdown()
        self.beginLoading()
        self.service.getMedicalRecord(idMedicalRecord: self.medicalRecordID, failure: { [weak self] (message) in
            self?.endLoading()
            self?.showAlert(title: Strings.alertTitle, message: message)
        }) { [weak self] (medicalRecord) in
            self?.endLoading()
            self?.medicalRecord = medicalRecord
            medicalRecord.attributes.forEach({ (attribute) in
                self?.dropdown.dataSource.append(attribute.name ?? "")
            })
            if let index = self?.attributeIndexSelected {
                let title = self?.medicalRecord?.attributes[index].name ?? ""
                self?.attributeSelectionButton.setTitle(title, for: .normal)
            } else {
                self?.attributeSelectionButton.setTitle(Strings.selectAttribute, for: .normal)
            }
            self?.tableView.reloadData()
        }
        self.setupTableView()
    }
    
    @IBAction func didTapAttributeSelectionButton(_ sender: Any) {
        self.dropdown.show()
    }
    
    private func setupDropdown() {
        self.dropdown = DropDown(anchorView: self.dropdownContainerView)
        self.dropdown.direction = .bottom
        self.dropdown.backgroundColor = Constant.Color.darkGreen
        self.dropdown.selectionBackgroundColor = Constant.Color.lightGreen
        self.dropdown.textColor = UIColor.white
        self.dropdown.cornerRadius = 5
        self.dropdown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.attributeIndexSelected = index
            let title = self?.medicalRecord?.attributes[index].name ?? ""
            self?.attributeSelectionButton.setTitle(title, for: .normal)
        }
    }
    
    private func setupTableView() {
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 100
        self.tableView.tableFooterView = UIView()
    }
}

extension MedicalRecordViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let index = self.attributeIndexSelected else { return 0 }
        let attribute = self.medicalRecord?.attributes[index]
        return attribute?.attributes?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let index = self.attributeIndexSelected else {
            return UITableViewCell()
        }
        guard let attribute = self.medicalRecord?.attributes[index] else {
            return UITableViewCell()
        }
        if attribute.level == 0 {
            let identifier = SingleAttributeTableViewCell.identifier
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! SingleAttributeTableViewCell
            cell.singleAttribute = attribute
            return cell
        } else {
            let identifier = MultipleAttributeTableViewCell.identifier
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MultipleAttributeTableViewCell
            guard let childAttribute = attribute.attributes?[indexPath.row] else {
                return cell
            }
            cell.multipleAttribute = childAttribute
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if self.medicalRecord == nil {
            return Strings.noMedicalRecord
        } else {
            return nil
        }
    }
}
