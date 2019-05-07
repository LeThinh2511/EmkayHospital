//
//  WorkdayList.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 5/7/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import Foundation

class WorkdayList: ServiceResponse {
    var workdays: [Workday]?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.workdays = try container.decodeIfPresent([Workday].self, forKey: .workdays)
        try super.init(from: decoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case workdays = "arr"
    }
}
