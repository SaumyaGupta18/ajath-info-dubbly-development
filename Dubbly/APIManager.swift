//
//  APIManager.swift
//  Dubbly
//
//  Created by apple on 12/02/24.
//

import Foundation
import Alamofire


protocol AccessTokenStorage: AnyObject {
    typealias JWT = String
    var accessToken: JWT { get set }
}


class AccessTokenStorageImpl: AccessTokenStorage {
    var accessToken: JWT = ""

    func setAccessToken(token: String) {
        self.accessToken = token
    }

    func getAccessToken() -> String {
        return self.accessToken
    }
}


final class RequestInterceptor: Alamofire.RequestInterceptor {

    private let storage: AccessTokenStorage

    init(storage: AccessTokenStorage) {
        self.storage = storage
    }

    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        guard urlRequest.url?.absoluteString.hasPrefix(BASE_URL) == true else {
            return completion(.success(urlRequest))
        }
        var urlRequest = urlRequest

        urlRequest.setValue("Bearer " + storage.accessToken, forHTTPHeaderField: "Authorization")

        completion(.success(urlRequest))
    }
}


class APIManager{
    let storage = AccessTokenStorageImpl()
    static let sharedInstance = APIManager()
    
    func callingRegisterAPI(register: RegisterModel, completion: @escaping(String)->()){
            let headers: HTTPHeaders = [
                .contentType("application/json")
            ]
            AF.request("\(BASE_URL)/api/api/register", method: .post, parameters: register, encoder: JSONParameterEncoder.default, headers: headers).response{ response in
                debugPrint(response)
                switch response.result{
                case .success(let data):
                    do{
                        let json = try JSONSerialization.jsonObject(with: data!, options: [])as!NSDictionary
                        if response.response?.statusCode == 200{
                            completion(json.object(forKey:"message")as! String)
                        }
                        else {
                            completion("")
                        }
                    }
                    catch{
                        print(error.localizedDescription)
                        completion("")
                    }
                case .failure(let err):
                    print(err.localizedDescription)
                    completion("")
                }
            }
        }
    
    func callingAboutAPI(about: AboutModel, completion: @escaping(String)->()){
            let headers: HTTPHeaders = [
                .contentType("application/json")
            ]
            AF.request("\(BASE_URL)/api/api/about", method: .post, parameters: about, encoder: JSONParameterEncoder.default, headers: headers).response{ response in
                debugPrint(response)
                switch response.result{
                case .success(let data):
                    do{
                        let json = try JSONSerialization.jsonObject(with: data!, options: [])as!NSDictionary
                        if response.response?.statusCode == 200{
                            completion(json.object(forKey:"message")as! String)
                        }
                        else {
                            completion("")
                        }
                    }
                    catch{
                        print(error.localizedDescription)
                        completion("")
                    }
                case .failure(let err):
                    print(err.localizedDescription)
                    completion("")
                }
            }
        }
    
    func callLoginApi(login: LoginModel, completion: @escaping (LoginResponse) -> ()){
        let headers: HTTPHeaders = [
            .contentType("application/json")
        ]
        AF.request("\(BASE_URL)/api/api/login", method: .post, parameters: login, encoder: JSONParameterEncoder.default, headers: headers).response{response in
            debugPrint(response)
            switch response.result{
            case .success(let data):
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                    
                    if response.response?.statusCode == 200{
                        self.storage.setAccessToken(token: json.object(forKey: "access_token") as! String)
                        print("Token: ", self.storage.getAccessToken())
                        completion(LoginResponse(message: json.object(forKey: "message") as! String, flag: 0))
                    }
                    else{
                        completion(LoginResponse(message: json.object(forKey: "detail") as! String, flag: 1))
                    }
                }
                catch{
                    print(error.localizedDescription)
                    completion(LoginResponse(message: "", flag: 2))
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(LoginResponse(message: "", flag: 2))
            }
        }
    }

    
    func ForgotPassword(forgetPassword: ForgetPasswordModel, completion: @escaping (LoginResponse) -> ()){
        let headers: HTTPHeaders = [
            .contentType("application/json")
        ]
        AF.request("\(BASE_URL)/api/api/forgotpass", method: .post, parameters: forgetPassword, encoder: JSONParameterEncoder.default, headers: headers).response{response in
            debugPrint(response)
            switch response.result{
            case .success(let data):
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                    
                    if response.response?.statusCode == 200{
                        let otp: NSNumber = json.object(forKey: "otp") as! NSNumber
                        completion(LoginResponse(message: otp.stringValue, flag: 0))
                    }
                    else{
                        completion(LoginResponse(message: json.object(forKey: "detail") as! String, flag: 1))
                    }
                }
                catch{
                    print(error.localizedDescription)
                    completion(LoginResponse(message: "", flag: 2))
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(LoginResponse(message: "", flag: 2))
            }
        }
    }
    
    func OTPVerify(verify: VerifyModel, completion: @escaping (LoginResponse) -> ()){
        let headers: HTTPHeaders = [
            .contentType("application/json")
        ]
        AF.request("\(BASE_URL)/api/api/otpverify", method: .post, parameters: verify, encoder: JSONParameterEncoder.default, headers: headers).response{response in
            debugPrint(response)
            switch response.result{
            case .success(let data):
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                    
                    if response.response?.statusCode == 200{
                        if json.object(forKey: "type") as! String == "success"{
                            self.storage.setAccessToken(token: json.object(forKey: "access_token") as! String)
                            print("Token: ", self.storage.getAccessToken())
                            completion(LoginResponse(message: json.object(forKey: "message") as! String, flag: 0))
                        }
                        completion(LoginResponse(message: json.object(forKey: "message") as! String, flag: 1))
                    }
                    else{
                        completion(LoginResponse(message: json.object(forKey: "detail") as! String, flag: 1))
                    }
                }
                catch{
                    print(error.localizedDescription)
                    completion(LoginResponse(message: "", flag: 2))
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(LoginResponse(message: "", flag: 2))
            }
            
        }
        
    }
    
    func ResetPass(reset: ResetModel, completion: @escaping (LoginResponse) -> ()){
        let headers: HTTPHeaders = [
            .authorization("Bearer \(self.storage.getAccessToken())"),
            .contentType("application/json")
        ]
        AF.request("\(BASE_URL)/api/api/resetpass", method: .post, parameters: reset, encoder: JSONParameterEncoder.default, headers: headers).response{response in
            debugPrint(response)
            switch response.result{
            case .success(let data):
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                    
                    if response.response?.statusCode == 200{
                            completion(LoginResponse(message: json.object(forKey: "message") as! String, flag: 0))
                    }
                    else{
                        completion(LoginResponse(message: json.object(forKey: "detail") as! String, flag: 1))
                    }
                }
                catch{
                    print(error.localizedDescription)
                    completion(LoginResponse(message: "", flag: 2))
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(LoginResponse(message: "", flag: 2))
            }
            
        }
    }
    
}
