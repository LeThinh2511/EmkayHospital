//
//  Enumerations.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 3/31/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import Foundation

enum Role: Int {
    case patient = 1
    case doctor = 2
    case unknown
}

enum Gender: String {
    case male = "0"
    case female = "1"
    case unknown
}
