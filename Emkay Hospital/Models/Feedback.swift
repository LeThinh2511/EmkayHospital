//
//  Feedback.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 5/8/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import Foundation

class Feedback: ServiceResponse {
    var id: String?
    var time: String?
    var content: String?
    var isSeen: Bool?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.time = try container.decodeIfPresent(String.self, forKey: .time)
        self.content = try container.decodeIfPresent(String.self, forKey: .content)
        self.isSeen = try container.decodeIfPresent(Bool.self, forKey: .isSeen)
        try super.init(from: decoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id = "idGopY"
        case time = "time"
        case content = "noiDung"
        case isSeen = "isSeen"
    }
}
