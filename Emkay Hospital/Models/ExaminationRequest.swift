//
//  ExaminationRequest.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 5/2/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import Foundation

class ExaminationRequest: ServiceResponse {
    var scheduleTime: Date?
    var content: String?
    var examinationTime: Date?
    var isProcessed: Bool = false
    var isProcessedTitle: String?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let scheduleTime = try container.decodeIfPresent(String.self, forKey: .scheduleTime)
        self.scheduleTime = Date.date(from: scheduleTime)
        self.content = try container.decodeIfPresent(String.self, forKey: .content)
        let examinationTime = try container.decodeIfPresent(String.self, forKey: .examinationTime)
        self.examinationTime = Date.date(from: examinationTime)
        self.isProcessed = try container.decodeIfPresent(Bool.self, forKey: .isProcessed) ?? false
        if self.isProcessed {
            self.isProcessedTitle = "Đã xử lý"
        } else {
            self.isProcessedTitle = "Chưa xử lý"
        }
        try super.init(from: decoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case scheduleTime = "timeDat"
        case content = "noiDung"
        case examinationTime = "timeKham"
        case isProcessed = "isComplete"
    }
}
