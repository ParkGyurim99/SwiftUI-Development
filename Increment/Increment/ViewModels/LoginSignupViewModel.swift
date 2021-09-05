//
//  LoginSignupViewModel.swift
//  Increment
//
//  Created by Park Gyurim on 2021/09/05.
//

import Foundation

final class LoginSignupViewModel : ObservableObject {
    private let mode : Mode
    @Published var emailText : String = ""
    @Published var passwordText : String = ""
    @Published var isValid : Bool = false
    
    init(mode : Mode) {
        self.mode = mode
    }
    
    var title : String {
        switch mode {
        case .login :
            return "Welcome Back!"
        case .signup :
            return "Create an Account"
        }
    }
    
    var subTitle : String {
        switch mode {
        case .login :
            return "Log in with your email"
        case .signup :
            return "Sign up via email"
        }
    }
    
    var buttonTitle : String {
        switch mode {
        case .login :
            return "Log in"
        case .signup :
            return "Sign up"
        }
    }
}

extension LoginSignupViewModel {
    enum Mode {
        case login
        case signup
    }
}
