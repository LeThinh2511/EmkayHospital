//
//  Presciption.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 5/2/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import Foundation

class Prescription: ServiceResponse {
    var drugs: [Drug]?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.drugs = try container.decodeIfPresent([Drug].self, forKey: .drugs)
        try super.init(from: decoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case drugs = "result"
    }
}
