//
//  Patient.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 4/20/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import Foundation

class Patient: ServiceResponse {
    var id: String!
    var name: String?
    var birthday: Date?
    var address: String?
    var phone: String?
    var insuranceID: String?
    var gender: Gender?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        let birthday = try container.decodeIfPresent(String.self, forKey: .birthday)
        self.birthday = Date.date(from: birthday)
        self.address = try container.decodeIfPresent(String.self, forKey: .address)
        self.phone = try container.decodeIfPresent(String.self, forKey: .phone)
        self.insuranceID = try container.decodeIfPresent(String.self, forKey: .insuranceID)
        let genderCode = try container.decodeIfPresent(String.self, forKey: .gender)
        self.gender = Gender(rawValue: genderCode ?? "") ?? .unknown
        try super.init(from: decoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case birthday = "birth"
        case address = "add"
        case phone = "phone"
        case insuranceID = "insurance"
        case gender = "gender"
    }
}
