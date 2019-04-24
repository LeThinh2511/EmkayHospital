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
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
    
    static func date(from date: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: date)
    }
}
