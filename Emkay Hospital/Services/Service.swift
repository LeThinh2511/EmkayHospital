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
    
    func login(username: String, password: String, failure: @escaping (String) -> Void, success: @escaping (Int) -> Void) {
        let parameters = [username, password]
        let url = API.login
        self.request(url: url, parameters: parameters) { (result) in
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
    
    private func request(url: String, parameters: [String], completion: @escaping (ServiceResult<[String: Any]>) -> Void) {
        guard let url = URL(string: API.login) else {
            completion(.failure(message: Messages.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = HTTPMethod.post.rawValue
        request.httpBody = try! JSONSerialization.data(withJSONObject: parameters)
        Alamofire.request(request)
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
