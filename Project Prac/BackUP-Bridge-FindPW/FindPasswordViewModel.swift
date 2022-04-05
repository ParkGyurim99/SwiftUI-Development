//
//  FindPasswordViewModel.swift
//  Bridge-iOS
//
//  Created by Park Gyurim on 2021/11/04.
//

import Foundation
import Combine
import Alamofire

final class FindPasswordViewModel : ObservableObject {
    @Published var buttonAction : Int = 0
    
    @Published var email : String = ""
    @Published var key : String = ""
    @Published var inputWrongKey : Bool = false
    
    @Published var password : String = ""
    @Published var passwordConfirmation : String = ""
    
    @Published var showPassword : Bool = false
    @Published var showPasswordConfirmation : Bool = false
        
    var isPasswordConfirmation : Bool { password != passwordConfirmation }
    
    var receivedToken : String = ""
    private var subscription = Set<AnyCancellable>()

    var titleText : String {
        switch buttonAction {
            case 0:
                return "Reset Password"
            case 1 :
                return "Check your mail box"
            case 2 :
                return "Enter your new Password"
            case 3 :
                return "You have successfully changed your password"
            default:
                return "get Error"
        }
    }
    
    var textFieldText : String {
        switch buttonAction {
            case 0:
                return "E-mail"
            case 1 :
                return "Enter your code"
            case 2 :
                return "Password"
            default:
                return "get Error"
        }
    }
    
    func nextButtonValidation(_ buttonActionCode : Int) -> Bool {
        // Return button disabling condition (true -> disable)
        switch buttonActionCode {
            case 0 :
                return email.isEmpty 
            case 1 :
                return key.isEmpty
            case 2 :
            return password.isEmpty || passwordConfirmation.isEmpty || isPasswordConfirmation //비번 두개 다르면 트루
            default :
                return true
        }
    }
    
    func apiCalling(_ buttonActionCode : Int) {
        switch buttonActionCode {
            case 0 :
                findingPassword_sendMail()
            case 1 :
                findingPassword_confirmCode()
            case 2 :
                findingPassword_chagePassword()
            default :
                print("")
        }
    }
    
    // APIs
    // API #45, params : email
    func findingPassword_sendMail() {
        let url = baseURL + "/email-auth/password"
        
        AF.request(url,
                   method: .post,
                   parameters: ["email" : email],
                   encoder: JSONParameterEncoder.prettyPrinted
        ).responseJSON { [weak self] response in
            print(response)
            guard let statusCode = response.response?.statusCode else { return }
            switch statusCode {
                case 200 :
                    print("Success : \(statusCode)")
                    self?.buttonAction += 1
                default :
                    print("Fail : \(statusCode)")
                    // 등록되지않은 이메일로 요청해도 실패를 반환하지 않아서 그냥 넘김
            }
        }
    }
    // Deprecated
    // API #46, params : email, key
    func findingPassword_confirmCode() {
        let url = baseURL + "/email-auth/password/confirm"
        
        AF.request(url,
                   method: .post,
                   parameters: ["email" : email, "key" : key],
                   encoder: JSONParameterEncoder.prettyPrinted
        ).responseJSON { [weak self] response in
            print(response)
            guard let statusCode = response.response?.statusCode else { return }
            switch statusCode {
                case 200 :
                    print("Success : \(statusCode)")
                    self?.buttonAction += 1
                default :
                    print("Fail : \(statusCode)")
                    self?.inputWrongKey = true
            }
        }.publishDecodable(type: FindpasswordResponse.self)
        .compactMap { $0.value }
        .sink { _ in }
         receiveValue: { [weak self] receivedValue in
            self?.receivedToken = receivedValue.token
         }.store(in: &subscription)
    }
    
    // API #42, params : password(new) with token
    func findingPassword_chagePassword() {
        let url = baseURL + "/password"
        let header: HTTPHeaders = [ "X-AUTH-TOKEN" : receivedToken ]

        AF.request(url,
                   method: .patch,
                   parameters: [ "password" : password ],
                   encoder: JSONParameterEncoder.prettyPrinted,
                   headers: header
        ).responseJSON { [weak self] response in
            print(response)
            guard let statusCode = response.response?.statusCode else { return }
            switch statusCode {
                case 200 :
                    print("Success : \(statusCode)")
                    self?.buttonAction += 1
                default :
                    print("Fail : \(statusCode)")
            }
        }
    }
}
