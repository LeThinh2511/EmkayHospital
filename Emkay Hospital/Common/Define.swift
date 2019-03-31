//
//  Define.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 3/30/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

struct Constant {
    struct ActivityIndicator {
        static let size: CGSize = {
            let width = System.ScreenSize.width / 3
            let height = width
            return CGSize(width: width, height: height)
        }()
        
        static let type = NVActivityIndicatorType.circleStrokeSpin
        static let color: UIColor? = UIColor.red
    }
}

struct System {
    struct ScreenSize {
        static let height = UIScreen.main.bounds.height
        static let width = UIScreen.main.bounds.width
    }
}

struct Messages {
    static let invalidURL = "Lỗi"
    static let configRequestFailure = "Lỗi"
    static let wrongUsernameOrPassword = "Tên đăng nhập hoặc mật khẩu không đúng."
    static let serverError = "Lỗi Server."
}

struct API {
    static let baseURL = "http://13.70.25.1:8080/DOANHTTT/rest/"
    static let login = API.baseURL + "account/login"
    
    struct Key {
        static let errorCode = "errCode"
        static let token = "token"
        static let errorMessage = "value"
        static let role = "role"
    }
}
