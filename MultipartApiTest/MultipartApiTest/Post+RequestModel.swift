//
//  PostInfo+Data.swift
//  MultipartApiTest
//
//  Created by Park Gyurim on 2021/09/30.
//

import Foundation

struct PostPayload : Codable {
    var postInfo : PostInfo
    var files : Data?
}

struct PostInfo : Codable {
    var title : String
    var price : Float
    var description : String
    var category : String
    var camps : [Int]
}
