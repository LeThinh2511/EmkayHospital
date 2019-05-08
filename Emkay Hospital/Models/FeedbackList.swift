//
//  FeedbackList.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 5/8/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import Foundation

class FeedbackList: ServiceResponse {
    var feedbacks: [Feedback]?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.feedbacks = try container.decodeIfPresent([Feedback].self, forKey: .feedbacks)
        try super.init(from: decoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case feedbacks = "arr"
    }
}
