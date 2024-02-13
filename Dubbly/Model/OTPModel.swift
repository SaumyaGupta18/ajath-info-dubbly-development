//
//  OTPModel.swift
//  Dubbly
//
//  Created by apple on 12/02/24.
//

import Foundation

struct ForgetPasswordModel: Encodable {
    let email: String
}

struct VerifyModel: Encodable {
    let email: String
    let otp: Int
}

struct ResetModel: Encodable{
    let password: String
}
