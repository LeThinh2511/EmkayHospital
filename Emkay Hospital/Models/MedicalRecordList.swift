//
//  MedicalRecordList.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 4/30/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import Foundation

class MedicalRecordList: ServiceResponse {
    var simpleMedicalRecords: [SimpleMedicalRecord]?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.simpleMedicalRecords = try container.decodeIfPresent([SimpleMedicalRecord].self, forKey: .simpleMedicalRecords)
        try super.init(from: decoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case simpleMedicalRecords = "result"
    }
}
