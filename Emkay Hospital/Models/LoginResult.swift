//
//  LoginResult.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 4/20/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import Foundation

class LoginResult: ServiceResponse {
    var token: String?
    var role: Int?
    var isHeadDoctor: Bool?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.token = try container.decodeIfPresent(String.self, forKey: .token)
        self.role = try container.decodeIfPresent(Int.self, forKey: .role)
        self.isHeadDoctor = try container.decodeIfPresent(Bool.self, forKey: .isHeadDoctor)
        try super.init(from: decoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case token = "token"
        case role = "role"
        case isHeadDoctor = "truongKhoa"
    }
}
