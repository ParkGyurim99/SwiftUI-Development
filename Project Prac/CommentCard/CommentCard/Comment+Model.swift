//
//  Comment+Model.swift
//  CommentCard
//
//  Created by Park Gyurim on 2023/02/28.
//

import Foundation

struct Comment: Codable, Hashable {
    var commentId: Int
    var content: String
    var like: Bool
    var likeCount: Int
    var comments: [Comment]? // 대댓글
    var createdAt: String
    var member: WriterInfo?
    var modifiable: Bool
}

struct WriterInfo: Codable, Hashable {
    var memberId: Int?
    var username: String?
    var description: String?
    var profileImage: String?
}
