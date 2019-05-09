//
//  MedicalRecord.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 4/29/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import Foundation

class MedicalRecord: ServiceResponse {
    var specialistName: String?
    var time: Date?
    var doctorName: String?
    var roomNumber: String?
    var doctorGender: Gender?
    var status: String?
    var recordStructure: String?
    var record: String?
    var attributes = [Attribute]()
    
    var statusTitle: String {
        guard let rawValue = self.status else { return "" }
        switch rawValue {
        case "0":
            return "Đang khám"
        case "1":
            return "Đang chờ"
        case "2":
            return "Đã khám"
        default:
            return ""
        }
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.specialistName = try container.decodeIfPresent(String.self, forKey: .specialistName)
        let time = try container.decodeIfPresent(String.self, forKey: .time)
        self.time = Date.date(from: time)
        self.doctorName = try container.decodeIfPresent(String.self, forKey: .doctorName)
        self.roomNumber = try container.decodeIfPresent(String.self, forKey: .roomNumber)
        let genderCode = try container.decodeIfPresent(String.self, forKey: .doctorGender)
        self.doctorGender = Gender(rawValue: genderCode ?? "") ?? .unknown
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.recordStructure = try container.decodeIfPresent(String.self, forKey: .recordStructure)
        self.record = try container.decodeIfPresent(String.self, forKey: .record)
        try super.init(from: decoder)
    }
    
    enum CodingKeys: String, CodingKey {
        case specialistName = "tenPhong"
        case time = "Time"
        case doctorName = "hoTenBacSi"
        case roomNumber = "soPhong"
        case doctorGender = "gioiTinhBacSi"
        case status = "status"
        case recordStructure = "mauHoSo"
        case record = "ketQua"
    }
    
    func getAttribute() {
        guard var recordStructure = self.recordStructure, var record = self.record else {
            return
        }
        recordStructure = String(recordStructure.map { (character) -> Character in
            character == "'" ? "\"" : character
        })
        record = String(record.map { (character) -> Character in
            character == "'" ? "\"" : character
        })
        guard let structureData = recordStructure.data(using: .utf8), let recordData = record.data(using: .utf8) else { return }
        do {
            guard let structure = try JSONSerialization.jsonObject(with: structureData, options : []) as? [String: Any], let record = try JSONSerialization.jsonObject(with: recordData, options: []) as? [String: Any] else {
                return
            }
            guard let array = structure["array"] as? [Any] else { return }
            var attributes = [Attribute]()
            for attribute in array {
                attributes.append(serializeJSon(formStructureData: attribute, record: record))
            }
            self.attributes = attributes
        } catch let error {
            dump(error)
            return
        }
    }
    
    private func serializeJSon(formStructureData: Any, record: [String: Any]) -> Attribute {
        let dictionary = formStructureData as! [String: Any]
        let isArray = dictionary[Attribute.Key.isArray.rawValue] as! Int
        if isArray == 0 {
            let name = dictionary[Attribute.Key.name.rawValue] as? String
            let key = dictionary[Attribute.Key.key.rawValue] as? String
            let type = dictionary[Attribute.Key.type.rawValue] as? String
            let attribute = Attribute(name: name, key: key, isArray: false)
            attribute.level = 0
            attribute.type = type
            if let value = record[key ?? ""] {
                let valueString = String(describing: value)
                if valueString == "0" {
                    attribute.value = "Không"
                } else if valueString == "1" {
                    attribute.value = "Có"
                } else {
                    attribute.value = valueString
                }
            }
            return attribute
        } else {
            let name = dictionary[Attribute.Key.name.rawValue] as? String
            let array = dictionary[Attribute.Key.array.rawValue] as! [Any]
            var attributes = [Attribute]()
            var maxChildAttributeLevel = 0
            for data in array {
                let childAttribute = serializeJSon(formStructureData: data, record: record)
                if childAttribute.level > maxChildAttributeLevel {
                    maxChildAttributeLevel = childAttribute.level
                }
                attributes.append(childAttribute)
            }
            let attribute = Attribute(name: name, key: nil, isArray: true)
            attribute.attributes = attributes
            attribute.level = maxChildAttributeLevel + 1
            return attribute
        }
    }
}
