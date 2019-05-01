//
//  ReexaminationList.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 5/1/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import Foundation

class ReexaminationList: ServiceResponse {
    var reexaminations: [Reexamination]?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.reexaminations = try container.decodeIfPresent([Reexamination].self, forKey: .reexaminations)
        try super.init(from: decoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case reexaminations = "result"
    }
}
