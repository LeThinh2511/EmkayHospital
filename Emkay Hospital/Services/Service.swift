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
    
    private init() {
    }
    
    func login(userName: String, password: String, failure: @escaping (String) -> Void, success: @escaping (Int) -> Void) {
        let arrayStringEncoding = ArrayStringEncoding(array: [userName, password])
        let url = API.login
        let headers = ["Content-Type": "application/json"]
        self.request(url: url, method: .post, encoding: arrayStringEncoding, headers: headers) { (result) in
            switch result {
            case .failure(let message):
                failure(message)
            case .success(let value):
                guard let errorCode = value[API.Key.errorCode] as? Int else {
                    failure(Messages.serverError)
                    return
                }
                guard errorCode == 0 else {
                    guard let errorMessage = value[API.Key.errorMessage] as? String else {
                        failure(Messages.serverError)
                        return
                    }
                    failure(errorMessage)
                    return
                }
                guard let token = value[API.Key.token] as? String, let role = value[API.Key.role] as? Int else {
                    failure(Messages.serverError)
                    return
                }
                Service.token = token
                success(role)
            }
        }
    }
    
    func checkQRCode(QRCode: String, failure: @escaping (String) -> Void, success: @escaping (String) -> Void) {
        let url = API.checkQRCode
        let stringEncoding = StringEncoding(string: QRCode)
        let headers = ["Content-Type": "application/json"]
        self.request(url: url, method: .post, encoding: stringEncoding, headers: headers) { (result) in
            switch result {
            case .failure(let message):
                failure(message)
            case .success(let value):
                guard let errorCode = value[API.Key.errorCode] as? Int else {
                    failure(Messages.serverError)
                    return
                }
                guard errorCode == 0 else {
                    guard let errorMessage = value[API.Key.errorMessage] as? String else {
                        failure(Messages.serverError)
                        return
                    }
                    failure(errorMessage)
                    return
                }
                guard let userName = value[API.Key.userName] as? String else {
                    failure(Messages.serverError)
                    return
                }
                success(userName)
            }
        }
    }
    
    func updatePasswordByQRCode(QRCode: String, newPassword: String, failure: @escaping (String) -> Void, success: @escaping (String) -> Void) {
        let url = API.updatePasswordByQRCode
        let arrayStringEncoding = ArrayStringEncoding(array: [QRCode, newPassword])
        let headers = ["Content-Type": "application/json"]
        self.request(url: url, method: .post, encoding: arrayStringEncoding, headers: headers) { (result) in
            switch result {
            case .failure(let message):
                failure(message)
            case .success(let value):
                guard let errorCode = value[API.Key.errorCode] as? Int else {
                    failure(Messages.serverError)
                    return
                }
                guard errorCode == 0 else {
                    guard let errorMessage = value[API.Key.errorMessage] as? String else {
                        failure(Messages.serverError)
                        return
                    }
                    failure(errorMessage)
                    return
                }
                guard let message = value[API.Key.successMessage] as? String else {
                    failure(Messages.serverError)
                    return
                }
                success(message)
            }
        }
    }
    
    private func request(url: String, method: HTTPMethod, encoding: ParameterEncoding, headers: HTTPHeaders?, completion: @escaping (ServiceResult<[String: Any]>) -> Void) {
        Alamofire.request(url, method: method, parameters: nil, encoding: encoding, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON { (response) in
                switch response.result {
                case .failure(_):
                    completion(.failure(message: Messages.configRequestFailure))
                case .success:
                    let value = response.result.value as! [String: Any]
                    completion(.success(data: value))
                }
        }
    }
    
}

enum ServiceResult<T> {
    case success(data: T)
    case failure(message: String)
}

struct ArrayStringEncoding: ParameterEncoding {
    private let array: [String]
    
    init(array: [String]) {
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
