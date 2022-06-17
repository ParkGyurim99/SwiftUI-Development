//
//  ResponseData.swift
//  MoyaPrac
//
//  Created by Park Gyurim on 2022/06/17.
//

import Foundation

struct OAuthLoginResponse : Codable, Equatable {
    var userId : Int
    var name : String
    var email : String
    var imageUrl : String
    var role : String
    var token : Token
}

struct Token : Codable, Equatable {
    var tokenType : String
    var accessToken : String
    var accessTokenValidityInMilliseconds : Int
    var refreshToken : String
    var refreshTokenValidityInMilliseconds : Int
}

struct DataResponse<T : Codable> : Codable {
    var count : Int
    var status : Int
    var body : T
}

struct UserInfo : Codable, Hashable {
    var userId : Int
    var name : String
    var email : String
    var imageUrl : String
}

struct PredictionInfo : Codable {
    var gongju : Int
    var baekje : Int
    var sejong : Int
    var gangjeonggoreyong : Int
    var gumi : Int
    var nakdan : Int
    var dalseong : Int
    var sangju : Int
    var changneyonghaman : Int
    var chilgok : Int
}
