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
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.token = try container.decodeIfPresent(String.self, forKey: .token)
        self.role = try container.decodeIfPresent(Int.self, forKey: .role)
        try super.init(from: decoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case token = "token"
        case role = "role"
    }
}
