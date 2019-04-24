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
    static var token = ""
    static var idPatient = ""
    
    private init() {
    }
    
    func sendFeedback(feedback: String, idSpecialist: String, failure: @escaping (String) -> Void, success: @escaping () -> Void) {
        let url = API.sendFeedback
        let headers = ["Content-Type": "application/json", API.Key.token: Service.token]
        let parameters = [API.Key.idSpecialist: idSpecialist, API.Key.feedback: feedback]
        self.request(url: url, method: HTTPMethod.post, parameters: parameters, encoding: URLEncoding(destination: .queryString), headers: headers) { (result: ServiceResult<ServiceResponse>) in
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
            case .success(let specialistList):
                if specialistList.errCode == 0 {
                    success(specialistList.specialists)
                } else {
                    failure(specialistList.value ?? Messages.unexpectedError)
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
            case .success(let patient):
                if patient.errCode == 0 {
                    success(patient)
                } else {
                    failure(patient.value ?? Messages.unexpectedError)
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
            case .success(let getListPatientResult):
                if getListPatientResult.errCode == 0 {
                    success(getListPatientResult.listPatient)
                } else {
                    failure(getListPatientResult.value ?? Messages.unexpectedError)
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
            case .success(let loginResult):
                if loginResult.errCode == 0 {
                    guard let role = loginResult.role else {
                        failure(Messages.unexpectedError)
                        return
                    }
                    Service.token = loginResult.token ?? ""
                    success(role)
                } else {
                    failure(loginResult.value ?? Messages.unexpectedError)
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
            case .success(let checkQRResult):
                if checkQRResult.errCode == 0 {
                    guard let userName = checkQRResult.userName else {
                        failure(Messages.unexpectedError)
                        return
                    }
                    success(userName)
                } else {
                    failure(checkQRResult.value ?? Messages.unexpectedError)
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
    
    private func request<T: Decodable>(url: String, method: HTTPMethod, parameters: Parameters?, encoding: ParameterEncoding, headers: HTTPHeaders?, completion: @escaping (ServiceResult<T>) -> Void) {
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
