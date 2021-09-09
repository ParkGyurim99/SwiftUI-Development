//
//  Challenge.swift
//  Increment
//
//  Created by Park Gyurim on 2021/08/30.
//

import Foundation
import FirebaseFirestoreSwift

struct Challenge : Codable { // Codable {
    @DocumentID var id : String?
    let exercise : String
    let startAmount : Int
    let increase : Int
    let length : Int
    let userId : String
    let startDate : Date
}
