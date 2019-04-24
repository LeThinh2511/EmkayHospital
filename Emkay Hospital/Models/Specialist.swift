//
//  Specialist.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 4/24/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import Foundation

class Specialist: ServiceResponse {
    var headDoctorName: String?
    var id: String!
    var specialistName: String?
    var headDoctorPhone: String?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.headDoctorName = try container.decodeIfPresent(String.self, forKey: .headDoctorName)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.specialistName = try container.decodeIfPresent(String.self, forKey: .specialistName)
        self.headDoctorPhone = try container.decodeIfPresent(String.self, forKey: .headDoctorPhone)
        try super.init(from: decoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case headDoctorName = "tenBacSiTruongKhoa"
        case id = "idChuyenKhoa"
        case specialistName = "tenChuyenkhoa"
        case headDoctorPhone = "sdtBacSiTruongKhoa"
    }
}
