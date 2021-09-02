//
//  Challenge.swift
//  Increment
//
//  Created by Park Gyurim on 2021/08/30.
//

import Foundation

struct Challenge : Codable, Hashable {
    let exercise : String
    let startAmount : Int
    let increase : Int
    let length : Int
    let userId : String
    let startDate : Date
}
