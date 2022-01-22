//
//  ChatroomViewModel.swift
//  stomp#1
//
//  Created by Park Gyurim on 2021/12/29.
//

import Foundation
import Alamofire
import Combine
import SwiftUI

final class ChatroomViewModel : ObservableObject {
    @Published var MessageList : [Message] = []
    @Published var lastMessageId : Int64 = 0
    private var subscription = Set<AnyCancellable>()
    var stompManager : StompManager
    let chatId : Int
    let token : String
    
    init(_ chatId : Int, token : String) {
        self.chatId = chatId
        self.token = token
        
        stompManager = StompManager(chatId, token: token)
    }
    
    func getChatContents(_ chatId : Int) {
        let header : HTTPHeaders = [ "X-AUTH-TOKEN" : token ]
        let url = "http://3.36.233.180:8080/chats/\(chatId)/messages?lastMessageId=0"
        
        AF.request(url,
                   method: .get,
                   encoding: URLEncoding.default,
                   headers: header)
            //.responseJSON{ json in print(json) }
            .publishDecodable(type : ChatContents.self)
            .compactMap { $0.value }
            .map { $0.messageList }
            .sink { completion in
                switch completion {
                case let .failure(error) :
                    print(error.localizedDescription)
                case .finished :
                    print("Get Chat Contents Finished")
                }
            } receiveValue: { [weak self] (receivedValue : [Message]) in
                //print(receivedValue)
                self?.MessageList = receivedValue
                if !receivedValue.isEmpty { self?.lastMessageId = receivedValue[0].message.messageId }
            }.store(in: &subscription)
    }
}
