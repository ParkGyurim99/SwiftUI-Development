//
//  Model.swift
//  KakaoVisionAPI_01
//
//  Created by Park Gyurim on 2021/10/06.
//

import Foundation

struct ResultKey : Codable {
    var result : FaceDetectionResult
    var rid : String // request id
}

struct FaceDetectionResult : Codable {
    var faces : [Face]
    var height : Int
    var width : Int
}

struct Face : Codable {
    var facial_attributes : FacialAttributes
    //var facial_points : FacialPoints
}

struct FacialAttributes : Codable {
    var gender : Gender
    var age : Float
}

struct Gender : Codable {
    var male : Float
    var female : Float
}
