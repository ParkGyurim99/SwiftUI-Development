//
//  LoginValidator.swift
//  UnitTestPrac
//
//  Created by Park Gyurim on 2022/04/11.
//

import Foundation

class LoginValidator {
    func isValidEmail(email:String) -> Bool { return email.contains("@") }
    func isValidPasword(password:String) -> Bool { return password.count < 5 }
}
