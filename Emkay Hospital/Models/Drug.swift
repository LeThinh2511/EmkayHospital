//
//  Drug.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 5/2/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import Foundation

class Drug: ServiceResponse {
    var drugName: String?
    var number: String?
    var unit: String?
    var price: String?
    var note: String?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.drugName = try container.decodeIfPresent(String.self, forKey: .drugName)
        self.number = try container.decodeIfPresent(String.self, forKey: .number)
        self.unit = try container.decodeIfPresent(String.self, forKey: .unit)
        self.price = try container.decodeIfPresent(String.self, forKey: .price)
        self.note = try container.decodeIfPresent(String.self, forKey: .note)
        try super.init(from: decoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case drugName = "tenchiphi"
        case number = "SoLuong"
        case unit = "Donvitinh"
        case price = "Dongia"
        case note = "Note"
    }
}
