//
//  Attribute.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 4/27/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import Foundation

class Attribute {
    var isArray: Bool
    var name: String?
    var value: String?
    var type: String?
    var key: String?
    var level: Int = 0
    var attributes: [Attribute]?
    
    init(name: String?, key: String?, isArray: Bool) {
        self.isArray = isArray
        self.name = name
        self.key = key
    }
    
    enum Key: String {
        case isArray = "isGroup"
        case name = "name"
        case key = "id"
        case array = "arr"
        case type = "type"
    }
}
