//
//  ContentViewModel.swift
//  stomp#1
//
//  Created by Park Gyurim on 2021/12/28.
//

import Foundation
import Alamofire
import Combine

final class ContentViewModel : ObservableObject {
    @Published var ChatList : [Chat] = []
    
    private let url = "http://3.36.233.180:8080/chats"
    private let token : String = "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ0ZXN0QGdtYWlsLmNvbSIsInJvbGVzIjpbIlJPTEVfVVNFUiJdLCJpYXQiOjE2NDA4NzE1MjMsImV4cCI6MTY0MDg3MzMyM30.qQoPFkVFiCgNC4sxi_OPte-rX6gfhf0gOy6-60frBOo"
    
    private var subscription = Set<AnyCancellable>()

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
                    print("Get Chats Finished")
                }
            } receiveValue: { [weak self] receivedValue in
                //print(receivedValue[0])
                self?.ChatList = receivedValue
                //print(self?.ChatList)
            }.store(in: &subscription)
    }
}
