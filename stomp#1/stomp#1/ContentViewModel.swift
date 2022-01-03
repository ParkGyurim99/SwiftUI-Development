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
    
    private let url = "http://3.36.233.180:8080/chats"
    private let token : String = "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ0ZXN0QGdtYWlsLmNvbSIsInJvbGVzIjpbIlJPTEVfQURNSU4iXSwiaWF0IjoxNjQxMjI3OTk3LCJleHAiOjE2NDEyMjk3OTd9.OTKZA1SWtcSGUV6ughhfGgTiJfRS2vOLn8IwRLvnQy0"

    init() {
        getChats()
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
