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
    
    struct Color {
        static let darkGreen: UIColor = UIColor(red: 58 / 255, green: 106 / 255, blue: 117 / 255, alpha: 1)
        static let lightGreen: UIColor = UIColor(red: 102 / 255, green: 139 / 255, blue: 148 / 255, alpha: 1)
    }
    
    static let feedbackMinLength = 25
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
    static let updatePatientInfoFailure = "Không thể cập nhật thông tin"
    static let updatePatientInfoSuccess = "Cập nhật thông tin thành công"
    static let unexpectedError = "Unexpected Error Occurred."
    static let sendFeedbackSuccess = "Góp ý thành công"
    static let feedbackNotLongEnough = "Nội dung góp ý cần lớn hơn \(Constant.feedbackMinLength) ký tự"
    static let accessTokenExpired = "Phiên làm việc hết hạn"
    static let scheduleExaminationContentEmpty = "Nhập nội dung đặt lịch khám"
    static let scheduleExaminationRequestSent = "Đã gửi yêu cầu đặt lịch khám"
    static let updatePasswordSuccess = "Đổi mật khẩu thành công"
    static let newPasswordNotMatch = "Mật khẩu mới không khớp"
}

struct Strings {
    static let alertTitle = "Thông báo"
    static let account = "Account: %@"
    static let enterPassword = "Nhập mật khẩu"
    static let ok = "OK"
    static let enter = "Nhập"
    static let edit = "Chỉnh sửa"
    static let save = "Lưu"
    static let cancel = "Huỷ"
    static let emptyAttribute = "Không có nội dung"
    static let examinationList = "Các đợt khám"
    static let medicalRecordList = "Các hồ sơ khám bệnh trong đợt khám"
    static let noExamination = "Chưa có thông tin đợt khám"
    static let noMedicalRecord = "Chưa có thông tin hồ sơ khám bệnh"
    static let selectAttribute = "Chọn"
    static let logout = "Đăng xuất"
    static let changePasword = "Đổi mật khẩu"
    static let changeAccount = "Tài khoản khác"
    static let oldPassword = "Mật khẩu cũ"
    static let newPassword = "Mật khẩu mới"
    static let confirmPassword = "Xác nhận mật khẩu"
    static let noExaminationRequest = "Chưa có yêu cầu đặt lịch khám"
    static let examinationRequests = "Danh sách lịch đã đặt"
}

struct API {
    static let baseURL = "http://168.61.49.94:8080/DOANHTTT/rest/"
    static let login = API.baseURL + "account/login"
    static let checkQRCode = API.baseURL + "account/checkQR"
    static let updatePasswordByQRCode = API.baseURL + "account/updatePassByQR"
    static let getInfo = API.baseURL + "account/getinfo"
    static let getListPatient = API.baseURL + "account/getListBenhNhan"
    static let getPatientInfo = API.baseURL + "account/getBenhNhanById"
    static let updatePatientInfo = API.baseURL + "patient/updateInformation?idBenhNhan=%@"
    static let getSpecialistList = API.baseURL + "recip/getChuyenKhoa"
    static let sendFeedback = API.baseURL + "patient/comment?idPhongBan=%@"
    static let getExaminationList = API.baseURL + "recip/getDotKhamByIdBenhNhan"
    static let getSimpleMedicalRecordList = API.baseURL + "recip/getHoSoByDotKham"
    static let getMedicalRecord = API.baseURL + "patient/xemHoSoKhamBenh"
    static let getReexaminationList = API.baseURL + "patient/xemlichtaikham"
    static let sendDeviceID = API.baseURL + "account/addDeviceId"
    static let scheduleExamination = API.baseURL + "patient/datLichKham?idBenhNhan=%@"
    static let updatePassword = API.baseURL + "account/update_pass"
    static let getPrescription = API.baseURL + "bill/getDrugByHSKB"
    static let getExaminationRequests = API.baseURL + "patient/getListDatLich"
    static let getWorkdayList = API.baseURL + "doctor/getLichLamViec"
    static let getFeedbackList = API.baseURL + "doctor/getListGopY"
    static let getStatus = API.baseURL + ""
    
    struct Key {
        static let errorCode = "errCode"
        static let token = "token"
        static let errorMessage = "value"
        static let role = "role"
        static let userName = "userName"
        static let successMessage = "value"
        static let listPatient = "listBenhNhan"
        static let idPatient = "idBenhNhan"
        static let idSpecialist = "idPhongBan"
        static let feedback = "NoiDung"
        static let idExamination = "idHSDK"
        static let idMedicalRecord = "idHoSo"
        static let medicalRecordID = "idHSKB"
    }
}

struct NotificationName {
    static let accessTokenExpired = Notification.Name("accessTokenExpired")
}

struct UserDefaultKey {
    static let accessToken = "accessToken"
    static let idPatient = "idPatient"
    static let isNotFirstLaunch = "isNotFirstLaunch"
    static let isDoctor = "isDoctor"
    static let isHeadDoctor = "isHeadDoctor"
}
