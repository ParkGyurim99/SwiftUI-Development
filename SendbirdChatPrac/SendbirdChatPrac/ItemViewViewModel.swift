//
//  ItemViewViewModel.swift
//  SendbirdChatPrac
//
//  Created by Park Gyurim on 2022/03/25.
//

import Foundation
import Alamofire
import Combine
import SendBirdSDK

final class ItemViewViewModel : ObservableObject {
    @Published var receivedChatUrl : String = ""
    @Published var showChatRoom : Bool = false
    
    private var subscription = Set<AnyCancellable>()
    
    func isChatExist(memberId : Int, postId : Int) {
        let url = "http://alb-dev-bridge-bridge-266265895.ap-northeast-2.elb.amazonaws.com/chats"
        let header : HTTPHeaders = ["X-AUTH-TOKEN" : "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJndXkwMjE4OThAbmF2ZXIuY29tIiwicm9sZXMiOlsiUk9MRV9VU0VSIl0sImlhdCI6MTY0ODE3MjQzOSwiZXhwIjoxNjQ4MTc0MjM5fQ.kX81b-r_bQV9QGuUXNQ8DXSap1k5QBvb6RZmdbCObhI"]
        
            AF.request(url,
                   method: .get,
                   parameters: ["member1Id" : 63, // my memberId
                                "member2Id" : memberId, // itemInfo.member.memberId
                                "postId" : postId], // itemInfo.postId
                   encoding: URLEncoding.default,
                   headers: header
        ).publishDecodable(type : Chat.self)
        .compactMap { $0 }
        .sink { completion in
            switch completion {
            case let .failure(error) :
                print(error.localizedDescription)
            case .finished :
                print("Check Chat Finished")
            }
        } receiveValue: { [weak self] receivedValue in
            switch receivedValue.result {
                case .success(let value): // 이미 존재하는 채팅
                    print("이미 존재하는 채팅 -> Link to", value.chatUrl)
                    self?.receivedChatUrl = value.chatUrl
                    self?.showChatRoom = true
                
                case .failure(let error): // 존재하지 않는 채팅 -> 생성
                    print("존재하지 않는 채팅 :", error)
                    
                    let params = SBDGroupChannelParams()
                    params.name = "Chat btw 63 and \(memberId) about \(postId)"
                    params.isDistinct = false
                    params.isPublic = true
                    
                    SBDGroupChannel.createChannel(with: params) { groupChannel, error in
                        guard let groupChannel = groupChannel, error == nil else { return }

                        // 채팅 생성시 상대방 초대
                        var userIds: [String] = []
                        userIds.append("\(memberId)")
                        groupChannel.inviteUserIds(userIds) { error in guard error == nil else { return } }

                        self?.receivedChatUrl = groupChannel.channelUrl
                    
                        let chatCreateUrl = "http://alb-dev-bridge-bridge-266265895.ap-northeast-2.elb.amazonaws.com/members/63/chats"
                        
                        AF.request(chatCreateUrl,
                                   method: .post,
                                   parameters: ["postId" : "\(postId)",
                                                "memberId" : "\(memberId)",
                                                "chatUrl" : groupChannel.channelUrl],
                                   encoder: JSONParameterEncoder.prettyPrinted,
                                   headers: header
                        ).responseJSON { response in print(response) }
                        
                        self?.showChatRoom = true
                    }
            }
        }.store(in: &subscription)
    }
}
