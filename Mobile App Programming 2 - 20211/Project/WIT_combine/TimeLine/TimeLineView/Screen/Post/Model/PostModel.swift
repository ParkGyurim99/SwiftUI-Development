//
//  PostModel.swift
//  WIT_combine
//
//  Created by LEESEUNGMIN on 2021/06/16.
//

import Foundation

struct PostModel: Encodable,Decodable {
    
    var caption: String
    var likes: [String: Bool]
    var geoLocation: String
    var ownerId: String
    var postId: String
    var username: String
    var profile: String
    var mediaurl: String
    var date: Double
    var likeCount: Int
    
}
