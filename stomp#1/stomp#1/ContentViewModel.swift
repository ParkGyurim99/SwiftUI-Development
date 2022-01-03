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
    var stompManagers : [Int : StompManager] = [:]
    
//    var stompManager1 : StompManager = StompManager()
//    var stompManager2 : StompManager = StompManager()
    
    private var subscription = Set<AnyCancellable>()
    
    private let url = "http://3.36.233.180:8080/chats"
    private let token : String = "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ0ZXN0QGdtYWlsLmNvbSIsInJvbGVzIjpbIlJPTEVfQURNSU4iXSwiaWF0IjoxNjQxMjIzODAwLCJleHAiOjE2NDEyMjU2MDB9.M9tbDDdckxpOTntaD_GZDcLZFEKzSPws_rujXaWvivY"

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
                //self?.stompClientLink()
                //print(self?.ChatList)
            }.store(in: &subscription)
    }
    
    func stompClientLink() {
        print("stomp link _ \(ChatList.count)")
        
        for chat in ChatList {
            let stompClient = StompManager()
            
            stompClient.registerSockect()
            //stompClient.subscribe(chatId: "\(chat.chatId)")
            //stompManagers.append([chat.chatId : stompClient])
            stompManagers[chat.chatId] = stompClient
        }
    }
}
