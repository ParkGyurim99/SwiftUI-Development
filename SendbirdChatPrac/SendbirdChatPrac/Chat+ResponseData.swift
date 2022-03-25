//
//  Chat+ResponseData.swift
//  SendbirdChatPrac
//
//  Created by Park Gyurim on 2022/03/25.
//

import Foundation

struct Chat : Codable, Hashable {
    var chatId : Int
    var chatUrl : String
    var memberFrom : ChatMember? // ChatSender
    var memberTo : ChatMember? // ChatReceiver
    var post : ChatAbout
}

struct ChatMember : Codable, Hashable {
    var memberId : Int
    var username : String
    var description : String
    var profileImage : String
}

struct ChatAbout : Codable, Hashable {
    var postId : Int
    var image : String
    var postType : String
    var title : String
}
