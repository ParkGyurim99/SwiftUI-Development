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
        
        Publishers.CombineLatest($emailText, $passwordText)
            .map { [weak self] email, password in
                return self?.isValidEmail(email) == true && self?.isValidPassword(password) == true
            }.assign(to: &$isValid)
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
            userService.login(email: emailText, password: passwordText).sink { completion in
                switch completion {
                case let .failure(error) :
                    print(error.localizedDescription)
                case .finished :
                    break
                }
            } receiveValue: { _ in }
            .store(in : &cancellables)

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
    func isValidEmail(_ email : String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Z0-9a-z._%+-]+\\.[A-Za-z]{2,64}" // regular expression
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        
        return emailPred.evaluate(with: email) && email.count > 5
    }
    
    func isValidPassword(_ password : String) -> Bool {
        return password.count > 5
    }
}
extension LoginSignupViewModel {
    enum Mode {
        case login
        case signup
    }
}
