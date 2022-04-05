//
//  Person.swift
//  WIT
//
//  Created by LEESEUNGMIN on 2021/05/18.
//

import Foundation

struct Person: Identifiable {
    var id: UUID = UUID()
    var name: String
    var content : [UserContent]?
}
