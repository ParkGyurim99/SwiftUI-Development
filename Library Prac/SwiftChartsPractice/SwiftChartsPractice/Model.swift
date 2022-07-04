//
//  Model.swift
//  SwiftChartsPractice
//
//  Created by Park Gyurim on 2022/07/04.
//

import Foundation

struct Pancakes : Identifiable {
    var id: UUID = UUID()

    let name : String
    let sales : Int
}

enum City : String {
    case Cupertino
    case SanFrancisco
}

struct SalesSummary : Identifiable {
    var id: UUID = UUID()
    
    let weekday : Date
    let sales : Int
}

struct Series : Identifiable {
    let city : String
    let sales : [SalesSummary]
    
    var id : String { city }
}
