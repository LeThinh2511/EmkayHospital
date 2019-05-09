//
//  SimpleMedicalRecord.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 4/30/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import Foundation

class SimpleMedicalRecord: ServiceResponse {
    var id: String!
    var status: String?
    var date: Date?
    var roomNumber: String?
    var roomName: String?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        let date = try container.decodeIfPresent(String.self, forKey: .date)
        self.date = Date.date(from: date)
        self.roomNumber = try container.decodeIfPresent(String.self, forKey: .roomNumber)
        self.roomName = try container.decodeIfPresent(String.self, forKey: .roomName)
        try super.init(from: decoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id = "IdHSKB"
        case status = "status"
        case date = "time"
        case roomNumber = "soPhong"
        case roomName = "tenPhong"
    }
}
