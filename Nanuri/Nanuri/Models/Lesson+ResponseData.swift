//
//  Lesson+ResponseData.swift
//  Nanuri
//
//  Created by Park Gyurim on 2022/01/30.
//

import Foundation

struct Lessons : Codable {
    var count : Int
    var status : Int
    var body : [Lesson]
}

struct Lesson : Codable, Hashable {
    var lessonId : Int
    var creator : String
    var lessonName : String
    var category : String
    var location : String
    var limitedNumber : Int
    var content: String
    var createDate : String // "2022-01-30T19:36:46.307"
    var status : Bool
    var images : [LessonImages]
}

struct LessonImages : Codable, Hashable {
    var lessonImgId : LessonImage
}

struct LessonImage : Codable, Hashable {
    var lessonId : Int
    var lessonImg : String
}
