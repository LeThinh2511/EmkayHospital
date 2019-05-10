//
//  Status.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 5/8/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import Foundation

class Status: ServiceResponse {
    var date: Date?
    var roomName: String?
    var roomNumber: String?
    var remainWaitingPeople: Int?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let date = try container.decodeIfPresent(String.self, forKey: .date)
        self.date = Date.date(from: date)
        self.roomName = try container.decodeIfPresent(String.self, forKey: .roomName)
        self.roomNumber = try container.decodeIfPresent(String.self, forKey: .roomNumber)
        self.remainWaitingPeople = try container.decodeIfPresent(Int.self, forKey: .remainWaitingPeople)
        try super.init(from: decoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case date = "ngayKham"
        case roomName = "tenPhong"
        case roomNumber = "soPhong"
        case remainWaitingPeople = "next"
    }
}
