//
//  ServiceResponse.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 4/20/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import Foundation

class ServiceResponse: Decodable {
    var errCode: Int!
    let value: String?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.errCode = try container.decodeIfPresent(Int.self, forKey: .errorCode)
        self.value = try container.decodeIfPresent(String.self, forKey: .value)
    }
    
    private enum CodingKeys: String, CodingKey {
        case errorCode = "errCode"
        case value = "value"
    }
}
