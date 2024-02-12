//
//  LoginModel.swift
//  Dubbly
//
//  Created by apple on 12/02/24.
//

import Foundation

struct LoginModel: Encodable{
    let email: String
    let password: String
}

struct LoginResponse {
    let message: String
    let flag: Int
}

