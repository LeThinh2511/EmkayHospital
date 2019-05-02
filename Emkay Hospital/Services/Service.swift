//
//  Service.swift
//  Patient Emkay Hospital
//
//  Created by ThinhLe on 3/30/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import Foundation
import Alamofire

class Service {
    static let sharedInstance = Service()
    static var token = "" {
        didSet {
            let key = UserDefaultKey.accessToken
            UserDefaults.standard.setValue(Service.token, forKey: key)
        }
    }
    static var idPatient = "" {
        didSet {
            let key = UserDefaultKey.idPatient
            UserDefaults.standard.setValue(Service.idPatient, forKey: key)
        }
    }
    
    static var deviceID = ""
    
    private init() {
        var key = UserDefaultKey.accessToken
        let token = UserDefaults.standard.value(forKey: key) as? String
        key = UserDefaultKey.idPatient
        let idPatient = UserDefaults.standard.value(forKey: key) as? String
        Service.token = token ?? ""
        Service.idPatient = idPatient ?? ""
    }
    
    func getPrescription(idMedicalRecord: String, failure: @escaping (String) -> Void, success: @escaping ([Drug]) -> Void) {
        let url = API.getPrescription
        let headers = ["Content-Type": "application/json", API.Key.token: Service.token]
        let parameters = [API.Key.medicalRecordID: idMedicalRecord]
        self.request(url: url, method: HTTPMethod.get, parameters: parameters, encoding: URLEncoding(destination: .queryString), headers: headers) { (result: ServiceResult<Prescription>) in
            switch result {
            case .failure(let message):
                failure(message)
            case .success(let response):
                if response.errCode == 0 {
                    success(response.drugs ?? [])
                } else {
                    failure(response.value ?? Messages.unexpectedError)
                }
            }
        }
    }
    
    func updatePassword(oldPassword: String, newPassword: String, failure: @escaping (String) -> Void, success: @escaping () -> Void) {
        let url = API.updatePassword
        let headers = ["Content-Type": "application/json", API.Key.token: Service.token]
        let arrayStringEncoding = ArrayStringEncoding(array: [oldPassword, newPassword])
        self.request(url: url, method: HTTPMethod.post, parameters: nil, encoding: arrayStringEncoding, headers: headers) { (result: ServiceResult<ServiceResponse>) in
            switch result {
            case .failure(let message):
                failure(message)
            case .success(let response):
                if response.errCode == 0 {
                    success()
                } else {
                    failure(response.value ?? Messages.unexpectedError)
                }
            }
        }
    }
    
    func scheduleExamination(content: String, date: String, failure: @escaping (String) -> Void, success: @escaping () -> Void) {
        let url = String(format: API.scheduleExamination, Service.idPatient)
        let headers = ["Content-Type": "application/json", API.Key.token: Service.token]
        let arrayStringEncoding = ArrayStringEncoding(array: [content, date])
        self.request(url: url, method: HTTPMethod.post, parameters: nil, encoding: arrayStringEncoding, headers: headers) { (result: ServiceResult<ServiceResponse>) in
            switch result {
            case .failure(let message):
                failure(message)
            case .success(let response):
                if response.errCode == 0 {
                    success()
                } else {
                    failure(response.value ?? Messages.unexpectedError)
                }
            }
        }
    }
    
    func sendDeviceID(failure: @escaping (String) -> Void, success: @escaping () -> Void) {
        let url = API.sendDeviceID
        let headers = ["Content-Type": "application/json", API.Key.token: Service.token]
        let stringEncoding = StringEncoding(string: Service.deviceID)
        self.request(url: url, method: HTTPMethod.post, parameters: nil, encoding: stringEncoding, headers: headers) { (result: ServiceResult<ServiceResponse>) in
            switch result {
            case .failure(let message):
                failure(message)
            case .success(let response):
                if response.errCode == 0 {
                    success()
                } else {
                    failure(response.value ?? Messages.unexpectedError)
                }
            }
        }
    }
    
    func getReexaminationList(failure: @escaping (String) -> Void, success: @escaping ([Reexamination]) -> Void) {
        let url = API.getReexaminationList
        let headers = ["Content-Type": "application/json", API.Key.token: Service.token]
        let parameters = [API.Key.idPatient: Service.idPatient]
        self.request(url: url, method: HTTPMethod.get, parameters: parameters, encoding: URLEncoding(destination: .queryString), headers: headers) { (result: ServiceResult<ReexaminationList>) in
            switch result {
            case .failure(let message):
                failure(message)
            case .success(let response):
                if response.errCode == 0 {
                    success(response.reexaminations ?? [])
                } else {
                    failure(response.value ?? Messages.unexpectedError)
                }
            }
        }
    }
    
    func getMedicalRecord(idMedicalRecord: String, failure: @escaping (String) -> Void, success: @escaping (MedicalRecord) -> Void) {
        let url = API.getMedicalRecord
        let headers = ["Content-Type": "application/json", API.Key.token: Service.token]
        let parameters = [API.Key.idMedicalRecord: idMedicalRecord]
        self.request(url: url, method: HTTPMethod.get, parameters: parameters, encoding: URLEncoding(destination: .queryString), headers: headers) { (result: ServiceResult<MedicalRecord>) in
            switch result {
            case .failure(let message):
                failure(message)
            case .success(let response):
                if response.errCode == 0 {
                    response.getAttribute()
                    success(response)
                } else {
                    failure(response.value ?? Messages.unexpectedError)
                }
            }
        }
    }
    
    func getSimpleMedicalRecordList(idExamination: String, failure: @escaping (String) -> Void, success: @escaping ([SimpleMedicalRecord]) -> Void) {
        let url = API.getSimpleMedicalRecordList
        let headers = ["Content-Type": "application/json", API.Key.token: Service.token]
        let parameters = [API.Key.idExamination: idExamination]
        self.request(url: url, method: HTTPMethod.get, parameters: parameters, encoding: URLEncoding(destination: .queryString), headers: headers) { (result: ServiceResult<MedicalRecordList>) in
            switch result {
            case .failure(let message):
                failure(message)
            case .success(let response):
                if response.errCode == 0 {
                    success(response.simpleMedicalRecords ?? [])
                } else {
                    failure(response.value ?? Messages.unexpectedError)
                }
            }
        }
    }
    
    func getExaminationList(failure: @escaping (String) -> Void, success: @escaping ([Examination]) -> Void) {
        let url = API.getExaminationList
        let headers = ["Content-Type": "application/json", API.Key.token: Service.token]
        let parameters = [API.Key.idPatient: Service.idPatient]
        self.request(url: url, method: HTTPMethod.get, parameters: parameters, encoding: URLEncoding(destination: .queryString), headers: headers) { (result: ServiceResult<ExaminationList>) in
            switch result {
            case .failure(let message):
                failure(message)
            case .success(let response):
                if response.errCode == 0 {
                    success(response.examinations ?? [])
                } else {
                    failure(response.value ?? Messages.unexpectedError)
                }
            }
        }
    }
    
    func sendFeedback(feedback: String, idSpecialist: String, failure: @escaping (String) -> Void, success: @escaping () -> Void) {
        let url = String(format: API.sendFeedback, idSpecialist)
        let headers = ["Content-Type": "application/json", API.Key.token: Service.token]
        let stringEncoding = StringEncoding(string: feedback)
        self.request(url: url, method: HTTPMethod.post, parameters: nil, encoding: stringEncoding, headers: headers) { (result: ServiceResult<ServiceResponse>) in
            switch result {
            case .failure(let message):
                failure(message)
            case .success(let response):
                if response.errCode == 0 {
                    success()
                } else {
                    failure(response.value ?? Messages.unexpectedError)
                }
            }
        }
    }
    
    func getSpecialistList(failure: @escaping (String) -> Void, success: @escaping ([Specialist]) -> Void) {
        let url = API.getSpecialistList
        let headers = ["Content-Type": "application/json"]
        self.request(url: url, method: HTTPMethod.get, parameters: nil, encoding: URLEncoding.default, headers: headers) { (result: ServiceResult<SpecialistList>) in
            switch result {
            case .failure(let message):
                failure(message)
            case .success(let response):
                if response.errCode == 0 {
                    success(response.specialists)
                } else {
                    failure(response.value ?? Messages.unexpectedError)
                }
            }
        }
    }
    
    func updatePatientInfo(patient: Patient, failure: @escaping (String) -> Void, success: @escaping () -> Void) {
        let url = String(format: API.updatePatientInfo, Service.idPatient)
        let headers = ["Content-Type": "application/json", API.Key.token: Service.token]
        let info = [patient.phone, patient.name, patient.birthday, patient.gender?.rawValue, patient.address]
        let arrayStringEncoding = ArrayStringEncoding(array: info)
        self.request(url: url, method: HTTPMethod.post, parameters: nil, encoding: arrayStringEncoding, headers: headers) { (result: ServiceResult<ServiceResponse>) in
            switch result {
            case .failure(let message):
                failure(message)
            case .success(let response):
                if response.errCode == 0 {
                    success()
                } else {
                    failure(response.value ?? Messages.unexpectedError)
                }
            }
        }
    }
    
    func getPatientInfo(failure: @escaping (String) -> Void, success: @escaping (Patient) -> Void) {
        let url = API.getPatientInfo
        let headers = ["Content-Type": "application/json", API.Key.token: Service.token]
        let parameters = [API.Key.idPatient : Service.idPatient]
        self.request(url: url, method: HTTPMethod.get, parameters: parameters, encoding: URLEncoding(destination: .queryString), headers: headers) { (result: ServiceResult<Patient>) in
            switch result {
            case .failure(let message):
                failure(message)
            case .success(let response):
                if response.errCode == 0 {
                    success(response)
                } else {
                    failure(response.value ?? Messages.unexpectedError)
                }
            }
        }
    }
    
    func getListPatient(failure: @escaping (String) -> Void, success: @escaping ([Patient]) -> Void) {
        let url = API.getListPatient
        let headers = ["Content-Type": "application/json", API.Key.token: Service.token]
        self.request(url: url, method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: headers) { (result: ServiceResult<GetListPatientResult>) in
            switch result {
            case .failure(let message):
                failure(message)
            case .success(let response):
                if response.errCode == 0 {
                    success(response.listPatient)
                } else {
                    failure(response.value ?? Messages.unexpectedError)
                }
            }
        }
    }
    
    func login(userName: String, password: String, failure: @escaping (String) -> Void, success: @escaping (Int) -> Void) {
        let arrayStringEncoding = ArrayStringEncoding(array: [userName, password])
        let url = API.login
        let headers = ["Content-Type": "application/json"]
        self.request(url: url, method: HTTPMethod.post, parameters: nil, encoding: arrayStringEncoding, headers: headers) { (result: ServiceResult<LoginResult>) in
            switch result {
            case .failure(let message):
                failure(message)
            case .success(let response):
                if response.errCode == 0 {
                    guard let role = response.role else {
                        failure(Messages.unexpectedError)
                        return
                    }
                    Service.token = response.token ?? ""
                    success(role)
                } else {
                    failure(response.value ?? Messages.unexpectedError)
                }
            }
        }
    }
    
    func checkQRCode(QRCode: String, failure: @escaping (String) -> Void, success: @escaping (String) -> Void) {
        let url = API.checkQRCode
        let stringEncoding = StringEncoding(string: QRCode)
        let headers = ["Content-Type": "application/json"]
        self.request(url: url, method: HTTPMethod.post, parameters: nil, encoding: stringEncoding, headers: headers) { (result: ServiceResult<CheckQRResult>) in
            switch result {
            case .failure(let message):
                failure(message)
            case .success(let response):
                if response.errCode == 0 {
                    guard let userName = response.userName else {
                        failure(Messages.unexpectedError)
                        return
                    }
                    success(userName)
                } else {
                    failure(response.value ?? Messages.unexpectedError)
                }
            }
        }
    }
    
    func updatePasswordByQRCode(QRCode: String, newPassword: String, failure: @escaping (String) -> Void, success: @escaping (String) -> Void) {
        let url = API.updatePasswordByQRCode
        let arrayStringEncoding = ArrayStringEncoding(array: [QRCode, newPassword])
        let headers = ["Content-Type": "application/json"]
        self.request(url: url, method: HTTPMethod.post, parameters: nil, encoding: arrayStringEncoding, headers: headers) { (result: ServiceResult<ServiceResponse>) in
            switch result {
            case .failure(let message):
                failure(message)
            case .success(let response):
                guard let message = response.value else {
                    failure(Messages.unexpectedError)
                    return
                }
                if response.errCode == 0 {
                    success(message)
                } else {
                    failure(message)
                }
            }
        }
    }
    
    private func request<T: ServiceResponse>(url: String, method: HTTPMethod, parameters: Parameters?, encoding: ParameterEncoding, headers: HTTPHeaders?, completion: @escaping (ServiceResult<T>) -> Void) {
        Alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
            .validate(statusCode: 200..<300)
            .responseData { (response) in
                switch response.result {
                case .failure(_):
                    completion(.failure(message: Messages.unexpectedError))
                case .success:
                    guard let data = response.data else {
                        completion(.failure(message: Messages.unexpectedError))
                        return
                    }
                    do {
                        let object = try JSONDecoder().decode(T.self, from: data)
                        if object.errCode == 2 {
                            let notification = Notification(name: NotificationName.accessTokenExpired)
                            NotificationCenter.default.post(notification)
                        }
                        completion(.success(data: object))
                    } catch let error {
                        dump("Request error: \(error)")
                        completion(.failure(message: Messages.unexpectedError))
                    }
                }
        }
    }
}

enum ServiceResult<T> {
    case success(data: T)
    case failure(message: String)
}

struct ArrayStringEncoding: ParameterEncoding {
    private let array: [String?]
    
    init(array: [String?]) {
        self.array = array
    }
    
    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var urlRequest = try urlRequest.asURLRequest()
        let data = try JSONSerialization.data(withJSONObject: array, options: [])
        urlRequest.httpBody = data
        return urlRequest
    }
}

struct StringEncoding: ParameterEncoding {
    private let string: String
    
    init(string: String) {
        self.string = string
    }
    
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try urlRequest.asURLRequest()
        request.httpBody = Data(string.utf8)
        return request
    }
}
