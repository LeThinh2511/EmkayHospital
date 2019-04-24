//
//  SpecialistList.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 4/24/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import Foundation

class SpecialistList: ServiceResponse {
    var specialists = [Specialist]()
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.specialists = try container.decodeIfPresent([Specialist].self, forKey: .specialists) ?? []
        try super.init(from: decoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case specialists = "arr"
    }
}
