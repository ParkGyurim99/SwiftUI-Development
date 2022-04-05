//
//  Chat+ResponseData.swift
//  stomp#1
//
//  Created by Park Gyurim on 2021/12/28.
//

import Foundation

struct Chats : Codable {
    var chatList : [Chat]
}

struct Chat : Codable, Hashable {
    var chatId : Int
    var memberFrom : ChatMember? // ChatSender
    var memberTo : ChatMember? // ChatReceiver
    var message : ChatLast? // Last Chatted message
    var post : ChatAbout
}

struct ChatMember : Codable, Hashable {
    var memberId : Int
    var username : String
    var description : String
    var profileImage : String
}

struct ChatLast : Codable, Hashable {
    var messageId : Int
    var message : String
    var image : String
    var createdAt : String
}

struct ChatAbout : Codable, Hashable {
    var postId : Int
    var image : String
//    var postType : String
//    var title : String
}

//struct ChatSender : Codable {
//    var memberId : Int
//    var username : String
//    var description : String
//    var profileImage : String
//}

//struct ChatReceiver : Codable {
//    var memberId : Int
//    var username : String
//    var description : String
//    var profileImage : String
//}


