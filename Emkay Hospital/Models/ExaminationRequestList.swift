//
//  ExaminationRequestList.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 5/2/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import Foundation

class ExaminationRequestList: ServiceResponse {
    var examinationRequests: [ExaminationRequest]?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.examinationRequests = try container.decodeIfPresent([ExaminationRequest].self, forKey: .examinationRequests)
        try super.init(from: decoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case examinationRequests = "arr"
    }
}
