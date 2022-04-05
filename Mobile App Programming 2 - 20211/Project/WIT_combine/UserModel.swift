//
//  UserModel.swift
//  WIT_combine
//
//  Created by LEESEUNGMIN on 2021/06/16.
//

import Foundation

struct  User : Encodable,Decodable {
    var uid : String
    var email : String
    var profileImageUrl : String
    var username:String
    var searchName: [String]
    var bio:String
}
