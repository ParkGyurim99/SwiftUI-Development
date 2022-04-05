//
//  CommentModel.swift
//  WIT_combine
//
//  Created by LEESEUNGMIN on 2021/06/17.
//

import Foundation

struct CommentModel : Encodable,Decodable,Identifiable {
    
    var id = UUID()
    var profile : String
    var postId : String
    var username: String
    var date: Double
    var comment: String
    var ownerId: String
}
