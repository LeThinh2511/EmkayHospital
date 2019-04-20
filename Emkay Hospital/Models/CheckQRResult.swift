//
//  CheckQRResult.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 4/20/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import Foundation

class CheckQRResult: ServiceResponse {
    var userName: String?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userName = try container.decodeIfPresent(String.self, forKey: .userName)
        try super.init(from: decoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case userName = "userName"
    }
}
