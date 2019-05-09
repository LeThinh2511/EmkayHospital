//
//  WorkdayViewController.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 5/7/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import UIKit
import JTAppleCalendar

class WorkdayViewController: BaseViewController {
    @IBOutlet weak var collectionView: JTAppleCalendarView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var shiftLabel: UILabel!
    @IBOutlet weak var roomNameLabel: UILabel!
    @IBOutlet weak var roomNumberLabel: UILabel!
    @IBOutlet weak var infoContainerView: UIView!
    
    var workdays = [Workday]()
    let numOfRowsInCalendar = 5
    var cellWidth: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.beginLoading()
        Service.sharedInstance.getWorkdayList(failure: { [weak self] (message) in
            self?.showAlert(title: Strings.alertTitle, message: message)
            self?.endLoading()
        }) { [weak self] (workdays) in
            self?.endLoading()
            self?.workdays = workdays
            self?.collectionView.reloadData()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let space = self.collectionView.minimumLineSpacing
        let viewWidth = self.view.frame.width
        self.cellWidth = (viewWidth - 6 * space) / 7
        self.collectionViewHeightConstraint.constant = self.cellWidth * CGFloat(self.numOfRowsInCalendar)
    }
    
    override func setupUI() {
        super.setupUI()
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM yyyy"
        let month = dateFormatter.string(from: date)
        dateFormatter.dateFormat = ""
        self.monthLabel.text = "Tháng \(month)"
    }
}

extension WorkdayViewController: JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource {
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        configureCell(for: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let identifier = WorkdayCell.identifier
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: identifier, for: indexPath) as! WorkdayCell
        configureCell(for: cell, cellState: cellState)
        return cell
    }
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let date = Date()
        let calendar = Calendar(identifier: .gregorian)
        let config = ConfigurationParameters(startDate: date, endDate: date, numberOfRows: self.numOfRowsInCalendar, calendar: calendar, generateInDates: .forFirstMonthOnly, generateOutDates: .tillEndOfRow, firstDayOfWeek: .monday, hasStrictBoundaries: true)
        return config
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        guard cellState.dateBelongsTo == .thisMonth, let workdayCell = cell as? WorkdayCell, workdayCell.isWorkday else { return }
        workdayCell.selectedView.isHidden = false
        self.infoContainerView.isHidden = false
        let workday = self.workdays.first { (workday) -> Bool in
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "dd-MM-yyyy"
            let date = dateFormater.string(from: cellState.date)
            return workday.date?.dateString() == date
        }
        self.shiftLabel.text = workday?.getShiftTitle()
        self.roomNameLabel.text = workday?.roomName
        self.roomNumberLabel.text = workday?.roomNumber
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        self.infoContainerView.isHidden = true
        guard cellState.dateBelongsTo == .thisMonth, let workdayCell = cell as? WorkdayCell, workdayCell.isWorkday else { return }
        workdayCell.selectedView.isHidden = true
    }
    
    private func configureCell(for cell: JTAppleCell, cellState: CellState) {
        guard let currentCell = cell as? WorkdayCell else {
            return
        }
        currentCell.dateLabel.text = cellState.text
        currentCell.workdayView.layer.cornerRadius = self.cellWidth / 2
        currentCell.workdayView.layer.masksToBounds = true
        currentCell.selectedView.layer.cornerRadius = self.cellWidth / 2
        currentCell.selectedView.layer.masksToBounds = true
        if cellState.dateBelongsTo == .thisMonth {
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "yyyy-MM-dd"
            let date = dateFormater.string(from: cellState.date)
            let isContained =  self.workdays.contains(where: { (workday) -> Bool in
                return workday.date?.dateString() == date
            })
            currentCell.isWorkday = isContained
            currentCell.workdayView.isHidden = !isContained
            currentCell.dateLabel.textColor = isContained ? .white : .black
        } else {
            currentCell.dateLabel.textColor = .gray
        }
    }
}
