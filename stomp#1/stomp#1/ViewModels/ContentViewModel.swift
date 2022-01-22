//
//  ContentViewModel.swift
//  stomp#1
//
//  Created by Park Gyurim on 2021/12/28.
//

import Foundation
import Alamofire
import Combine
import SwiftUI

final class ContentViewModel : ObservableObject {
    @Published var ChatList : [Chat] = []
    private var subscription = Set<AnyCancellable>()
    private let signInUrl : String = "http://3.36.233.180:8080/sign-in"
    private let url = "http://3.36.233.180:8080/chats"
    var signInResponse : SignInResponse?
    var token = ""
    
    init() {
        signIn()
    }
    
    func signIn() {
        AF.request(signInUrl,
                   method: .post,
                   parameters: ["email" : "test@gmail.com", "password" : "test"],
                   encoder: JSONParameterEncoder.prettyPrinted
        )
            .responseJSON { response in
                guard let statusCode = response.response?.statusCode else { return }
                switch statusCode {
                case 200 :
                    print("SignIn Success : \(statusCode)")
                default :
                    print("SignIn Fail : \(statusCode)")
                }
            }
            .publishDecodable(type: SignInResponse.self)
            .compactMap{ $0.value }
            //.map { $0 }
            .sink { completion in
                switch completion {
                    case let .failure(error) :
                        print(error.localizedDescription)
                    case .finished :
                        print("Sign in Finished")
                }
            } receiveValue: { [weak self] (receivedValue : SignInResponse) in
                print(receivedValue)
                self?.signInResponse = .init(
                    memberId: receivedValue.memberId,
                    name: receivedValue.name,
                    username: receivedValue.username,
                    token: receivedValue.token,
                    profileImage: receivedValue.profileImage,
                    description: receivedValue.description,
                    createdAt: receivedValue.createdAt
                )
                self?.token = receivedValue.token.accessToken
            }.store(in: &subscription)
    }
    
    func getChats() {
        let header : HTTPHeaders = [ "X-AUTH-TOKEN" : token ]
        
        AF.request(url,
                   method: .get,
                   encoding: URLEncoding.default,
                   headers: header)
            //.responseJSON{ json in print(json) }
            .publishDecodable(type : Chats.self)
            .compactMap { $0.value }
            .map { $0.chatList }
            .sink { completion in
                switch completion {
                case let .failure(error) :
                    print(error.localizedDescription)
                case .finished :
                    print("Get Chats List Finished")
                }
            } receiveValue: { [weak self] receivedValue in
                //print(receivedValue[0])
                self?.ChatList = receivedValue
                //print(self?.ChatList)
            }.store(in: &subscription)
    }
}
