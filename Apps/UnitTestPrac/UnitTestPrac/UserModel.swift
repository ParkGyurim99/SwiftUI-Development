//
//  UserModel.swift
//  UnitTestPrac
//
//  Created by Park Gyurim on 2022/04/11.
//

import Foundation

struct User {
    let email : String
    let password : String
    
    init(email : String, password : String) {
        self.email = email
        self.password = password
    }
}
