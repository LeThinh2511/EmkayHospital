//
//  Examination.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 4/30/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import Foundation

class Examination: ServiceResponse {
    var id: String!
    var diseaseInfo: String?
    var date: Date?
    var status: String?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.diseaseInfo = try container.decodeIfPresent(String.self, forKey: .diseaseInfo)
        let date = try container.decodeIfPresent(String.self, forKey: .date)
        self.date = Date.date(from: date)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        try super.init(from: decoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id = "IdHoSoDotKham"
        case diseaseInfo = "ThongTinBenh"
        case date = "NgayKham"
        case status = "Status"
    }
}
