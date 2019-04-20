//
//  GetListPatientResult.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 4/20/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import Foundation

class GetListPatientResult: ServiceResponse {
    var listPatient = [Patient]()
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.listPatient = try container.decodeIfPresent([Patient].self, forKey: .listPatient) ?? []
        try super.init(from: decoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case listPatient = "listBenhNhan"
    }
}
