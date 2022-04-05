//
//  UserContent.swift
//  WIT
//
//  Created by LEESEUNGMIN on 2021/05/23.
//

import Foundation


struct UserContent {
    var id: UUID = UUID()
    var image: String
    var desc: String
    var owner: Person
    var likeCount: Int = Int.random(in: 0..<100)
    var comments: [Comment]?
}
