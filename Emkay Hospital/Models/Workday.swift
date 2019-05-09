//
//  Workday.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 5/7/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import Foundation

class Workday: ServiceResponse {
    var date: Date?
    var shift: String?
    var roomName: String?
    var roomNumber: String?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let date = try container.decodeIfPresent(String.self, forKey: .date)
        self.date = Date.date(from: date)
        self.roomName = try container.decodeIfPresent(String.self, forKey: .roomName)
        self.roomNumber = try container.decodeIfPresent(String.self, forKey: .roomNumber)
        self.shift = try container.decodeIfPresent(String.self, forKey: .shift)
        try super.init(from: decoder)
    }
    
    func getShiftTitle() -> String {
        switch self.shift {
        case "1":
            return "Sáng"
        case "2":
            return "Chiều"
        case "3":
            return "Tối"
        default:
            return ""
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case date = "ngay"
        case shift = "buoi"
        case roomName = "tenPhong"
        case roomNumber = "soPhong"
    }
}
