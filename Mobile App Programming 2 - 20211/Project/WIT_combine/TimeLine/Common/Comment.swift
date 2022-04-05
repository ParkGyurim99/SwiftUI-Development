//
//  Comment.swift
//  WIT
//
//  Created by LEESEUNGMIN on 2021/05/24.
//

import Foundation


struct Comment: Identifiable {
    var id: UUID = UUID()
    var owner: Person
    var respondingId: UUID?
    var responses: [Comment]?
    var text: String
    var likeCount: Int = Int.random(in: 0..<5)
    var lastModifiedOn: Date = Date()
}
