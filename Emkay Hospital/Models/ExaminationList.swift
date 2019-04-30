//
//  ExaminationList.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 4/30/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import Foundation

class ExaminationList: ServiceResponse {
    var examinations: [Examination]?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.examinations = try container.decodeIfPresent([Examination].self, forKey: .examinations)
        try super.init(from: decoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case examinations = "result"
    }
}
