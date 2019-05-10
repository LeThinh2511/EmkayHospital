//
//  SelectPatientViewController.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 4/20/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import UIKit

class SelectPatientViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var patientList = [Patient]()
    let service = Service.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.beginLoading()
        service.getListPatient(failure: { [weak self] (message) in
            self?.endLoading()
            self?.showAlert(title: Strings.alertTitle, message: message)
        }) { [weak self] (patientList) in
            self?.service.getPatientInfo(failure: { (message) in
                self?.endLoading()
                self?.showAlert(title: Strings.alertTitle, message: message)
            }, success: { (patient) in
                self?.endLoading()
                self?.patientList = patientList
                self?.patientList.append(patient)
                self?.tableView.reloadData()
            })
        }
        
    }
    
    private func setupTableView() {
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableView.automaticDimension
    }
}

extension SelectPatientViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.patientList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = PatientTableViewCell.identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! PatientTableViewCell
        let patient = self.patientList[indexPath.row]
        cell.patient = patient
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let patient = self.patientList[indexPath.row]
        if let id = patient.id {
            Service.idPatient = id
            var key = UserDefaultKey.isDoctor
            UserDefaults.standard.set(false, forKey: key)
            key = UserDefaultKey.isHeadDoctor
            UserDefaults.standard.set(false, forKey: key)
        } else {
            var key = UserDefaultKey.isDoctor
            UserDefaults.standard.set(true, forKey: key)
            key = UserDefaultKey.isHeadDoctor
            UserDefaults.standard.set(true, forKey: key)
        }
        let storyboardName = UIStoryboard.patientStoryboard
        let viewController: PatientTabBarController = UIStoryboard.initViewController(in: storyboardName)
        self.present(viewController, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
