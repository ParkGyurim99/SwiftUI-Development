//
//  ChatroomViewModel.swift
//  stomp#1
//
//  Created by Park Gyurim on 2021/12/29.
//

import Foundation
import Alamofire
import Combine

final class ChatroomViewModel : ObservableObject {
    @Published var MessageList : [Message] = []
    @Published var lastMessageId : Int64 = 0
    
    //private var url : String
    private let token : String = "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ0ZXN0QGdtYWlsLmNvbSIsInJvbGVzIjpbIlJPTEVfVVNFUiJdLCJpYXQiOjE2NDA4ODU2NDksImV4cCI6MTY0MDg4NzQ0OX0.u7kzIvolxxnxetkjo-Cypy8OGya8GsBrOYfrrDNiPvE"
    
    private var subscription = Set<AnyCancellable>()

    init(_ chatId : Int) {
        //url = "http://3.36.233.180:8080/chats/\(chatId)/messages?lastMessageId=0"
        getChatContents(chatId)
    }
    
//    init(_ chatId : Int, lastMessageId : Int) { // 에전 메시지 조회
//        url = "http://3.36.233.180:8080/chats/\(chatId)/messages?lastMessageId=\(lastMessageId)"
//    }
    
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
