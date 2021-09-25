//
//  RandomUser+ResponseData.swift
//  ApiRequestPrac
//
//  Created by Park Gyurim on 2021/09/25.
//

// For Parsing

import Foundation

struct RandomUser : Codable, Identifiable, CustomStringConvertible {
    var id = UUID()
    var name : Name
    var photo : Photo
    
    private enum CodingKeys : String, CodingKey {
        case name = "name"
        case photo = "picture" // JSON 파일 상의 이름이 picture 이지만 photo로 사용한다고 명시하는 것
    }
    
    static func getDummy() -> Self {
        return RandomUser(name: .getDummy(), photo: .getDummy())
    }
    
    var profileImageUrl : URL {
        get {
            URL(string : photo.medium)!
        }
    }
    
    var description: String {
        return name.description
    }
}

struct Name : Codable, CustomStringConvertible {
    var title : String
    var first : String
    var last : String
    // 그대로 사용하고 싶을 경우 CodingKeys 를 만들지 않아도 됨.
    
    var description: String {
        return "\(title). \(first) \(last)"
    }
    
    static func getDummy() -> Self {
        return Name(title: "KING", first: "GYURIM", last: "PARK")
    }
}

struct Photo : Codable{
    var large : String
    var medium : String
    var thumbnail : String
    
    static func getDummy() -> Self {
        return Photo(
            large: "https://www.hapskorea.com/wp-content/uploads/2021/03/bigmac-korea.jpg",
            medium: "https://www.hapskorea.com/wp-content/uploads/2021/03/bigmac-korea.jpg",
            thumbnail: "https://www.hapskorea.com/wp-content/uploads/2021/03/bigmac-korea.jpg"
        )
    }
}

struct Info : Codable{
    var seed : String
    var resultsCount : Int
    var page : Int
    var version : String
    
    private enum CodingKeys : String, CodingKey {
        case seed = "seed"
        case resultsCount = "results"
        case page = "page"
        case version = "version"
    }
}

struct RandomUserResponse : Codable, CustomStringConvertible  {
    var results : [RandomUser]
    var info : Info
    
    private enum CodingKeys : String, CodingKey {
        case results, info
    }
    var description: String {
        return "result.count : \(results.count)\n info : \(info.seed)"
    }
}
