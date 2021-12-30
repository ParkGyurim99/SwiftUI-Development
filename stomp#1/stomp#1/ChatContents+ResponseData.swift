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
    var member : Sender?
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

func convertReturnedDateString(_ timeString : String) -> String {
    var str = timeString
    
    str.removeSubrange(str.index(str.startIndex, offsetBy: 19)..<str.endIndex) // 바뀐부분
    str.remove(at: str.index(str.startIndex, offsetBy: 10))
    str.insert(" ", at: str.index(str.startIndex, offsetBy: 10))
    
    let korNow = Date(timeIntervalSinceNow: 32400) // UTC + 9H
    let timetravel = korNow.timeIntervalSince(str.toDate() ?? Date())
    
    if Int(timetravel) < 60 {
        return "\(Int(timetravel)) Seconds ago"
    } else if (60 <= Int(timetravel)) && (Int(timetravel) < 3600) {
        return "\(Int(timetravel) / 60) Minutes ago"
    } else if (3600 <= Int(timetravel)) && (Int(timetravel) < 86400) {
        return "\(Int(timetravel) / 3600) Hours ago"
    } else if (86400 <= Int(timetravel)) && (Int(timetravel) < (86400 * 7)) { // 7일까지
        return "\(Int(timetravel) / 86400) Days ago"
    } else {
        str.removeSubrange(str.index(str.endIndex, offsetBy: -9)..<str.endIndex)
        return str
    }
}

extension String {
    func toDate() -> Date? { //"yyyy-MM-dd HH:mm:ss"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        if let date = dateFormatter.date(from: self) { return date }
        else { return nil }
    }
}
