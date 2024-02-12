//
//  RegisterModel.swift
//  Dubbly
//
//  Created by apple on 12/02/24.
//

import Foundation

struct RegisterModel: Encodable{
    let name: String
    let email:String
    let phone:String
    let password: String
}
