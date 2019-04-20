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
            let width = System.ScreenSize.width / 8
            let height = width
            return CGSize(width: width, height: height)
        }()
        
        static let type = NVActivityIndicatorType.circleStrokeSpin
        static let color: UIColor? = UIColor(red: 58 / 255, green: 106 / 255, blue: 117 / 255, alpha: 1)
    }
}

struct System {
    struct ScreenSize {
        static let height = UIScreen.main.bounds.height
        static let width = UIScreen.main.bounds.width
    }
}

struct Messages {
    static let wrongUserNameOrPassword = "Tên đăng nhập hoặc mật khẩu không đúng."
    static let serverError = "Lỗi Server."
    static let missingUserNameOrPassword = "Vui lòng điền đầy đủ thông tin."
    static let getListPatientFailure = "Không thể hiện thị danh sách bệnh nhân."
    static let unexpectedError = "Unexpected Error Occurred."
}

struct Strings {
    static let alertTitle = "Thông báo"
    static let account = "Account: %@"
    static let enterPassword = "Nhập mật khẩu"
    static let ok = "OK"
    static let enter = "Nhập"
}

struct API {
    static let baseURL = "http://168.61.49.94:8080/DOANHTTT/rest/"
    static let login = API.baseURL + "account/login"
    static let checkQRCode = API.baseURL + "account/checkQR"
    static let updatePasswordByQRCode = API.baseURL + "account/updatePassByQR"
    static let getInfo = API.baseURL + "account/getinfo"
    static let changePassword = API.baseURL + "account/update_pass"
    static let getListPatient = API.baseURL + "account/getListBenhNhan"
    static let getPatientInfo = API.baseURL + "account/getBenhNhanById"
    
    struct Key {
        static let errorCode = "errCode"
        static let token = "token"
        static let errorMessage = "value"
        static let role = "role"
        static let userName = "userName"
        static let successMessage = "value"
        static let listPatient = "listBenhNhan"
        static let idPatient = "idBenhNhan"
    }
}
