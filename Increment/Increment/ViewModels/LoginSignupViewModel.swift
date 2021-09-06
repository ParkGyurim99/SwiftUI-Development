//
//  LoginSignupViewModel.swift
//  Increment
//
//  Created by Park Gyurim on 2021/09/05.
//

import SwiftUI
import Combine

final class LoginSignupViewModel : ObservableObject {
    private let mode : Mode
    
    @Published var emailText : String = ""
    @Published var passwordText : String = ""
    @Published var isValid : Bool = false
    
    @Binding var isPushed : Bool
    
    private(set) var emailPlaceholderText = "e-mail"
    private(set) var passwordPlaceholderText = "password"
    
    private let userService : UserServiceProtocol
    private var cancellables : [AnyCancellable] = []
    
    init(mode : Mode, userService : UserServiceProtocol = UserService(), isPushed : Binding<Bool>) {
        self.mode = mode
        self.userService = userService
        self._isPushed = isPushed
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
    
    func tappedActionButton() {
        switch mode {
        case .login :
            print("login")
        case .signup :
            userService.linkAccount(email : emailText, password : passwordText).sink { [weak self] completion in
                switch completion {
                case let .failure(error) :
                    print(error.localizedDescription)
                case .finished :
                    print("finished")
                    self?.isPushed = false
                }
            } receiveValue: { _ in }
            .store(in : &cancellables)
        }
    }
}

extension LoginSignupViewModel {
    enum Mode {
        case login
        case signup
    }
}
