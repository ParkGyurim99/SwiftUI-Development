//
//  ChatContents+ResponseData.swift
//  stomp#1
//
//  Created by Park Gyurim on 2021/12/29.
//

import Foundation

struct ChatContents : Codable {
    var messageList : [Message]
}

struct Message : Codable, Hashable {
    var member : Sender
    var message : MessageContents
}

struct Sender : Codable, Hashable {
    var memberId : Int
    var username : String
    var description : String
    var profileImage : String
}

struct MessageContents : Codable, Hashable {
    var messageId : Int64
    var message : String
    var image : String
    var createdAt : String
}
