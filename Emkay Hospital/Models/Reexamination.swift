//
//  Reexamination.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 5/1/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import Foundation

class Reexamination: ServiceResponse {
    var roomName: String?
    var roomNumber: String?
    var doctorName: String?
    var date: Date?
    var shift: String?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.doctorName = try container.decodeIfPresent(String.self, forKey: .doctorName)
        self.shift = try container.decodeIfPresent(String.self, forKey: .shift)
        let date = try container.decodeIfPresent(String.self, forKey: .date)
        self.date = Date.date(from: date)
        self.roomNumber = try container.decodeIfPresent(String.self, forKey: .roomNumber)
        self.roomName = try container.decodeIfPresent(String.self, forKey: .roomName)
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
        case roomName = "TenPhong"
        case roomNumber = "SoPhong"
        case doctorName = "HoTen"
        case date = "Ngay"
        case shift = "Buoi"
    }
}
