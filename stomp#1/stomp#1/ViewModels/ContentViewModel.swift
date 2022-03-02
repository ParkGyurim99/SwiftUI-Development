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
    private let signInUrl : String = "http://NLB-DEV-BRIDGE-BRIDGE-aa5fd40a1346d1ae.elb.ap-northeast-2.amazonaws.com/sign-in"
    private let url = "http://NLB-DEV-BRIDGE-BRIDGE-aa5fd40a1346d1ae.elb.ap-northeast-2.amazonaws.com/chats"
    var signInResponse : SignInResponse?
    var token = ""
    
    init() {
        signIn()
    }
    
    func signIn() {
        AF.request(signInUrl,
                   method: .post,
                   parameters: ["email" : "guy021898@naver.com",
                                "password" : "1234",
                                "deviceCode" : String(UIDevice.current.identifierForVendor!.uuidString),
                                //MARK: TEMPORAL FCM TOKEN
                                "fcmToken" : "dihWMDcUVUBCsRFyxSa078:APA91bG-jKjLllf5KtEBhMMksIjm8W3e6Nvswp783LVOQmYNXptN0-Swe-CWX2gAGUhamdgakpcKutKOQ5fW82lTrOFHVC237kGt0dKErCxU-bNEVXU6R6qy7V229oDcLVhdaWSVEJ8F"],
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
