//
//  DateExtension.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 4/24/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import Foundation

extension Date {
    func dateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: self)
    }
    
    static func date(from date: String?) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: date ?? "") {
            return date
        }
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.S"
        if let date = dateFormatter.date(from: date ?? "") {
            return date
        }
        dateFormatter.dateFormat = "dd-MM-yyyy"
        if let date = dateFormatter.date(from: date ?? "") {
            return date
        }
        return nil
    }
}
