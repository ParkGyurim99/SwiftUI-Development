//
//  SignIn+ResponseData.swift
//  Bridge-iOS
//
//  Created by Park Gyurim on 2021/09/28.
//

import Foundation

struct SignInResponse : Codable {
    var memberId : Int
    var name : String
    var username : String
    var token : Token
    var profileImage : String
    var description : String
    var createdAt : String
}

struct Token : Codable {
    var accessToken : String
    var accessTokenExpiresIn : Int
    var refreshToken : String
    var refreshTokenExpiresIn : Int
}

