//
//  Card.swift
//  Wallet
//
//  Created by Park Gyurim on 2021/08/19.
//

import SwiftUI

struct Card : Hashable {
    // initialized variables
    let income : Int
    let expenses : Int
    var balance : Int { income - expenses }
    let cardNumber : String
    let imageName : String
    //
    
    var isSelected : Bool = false
    var backgroundColor : Color {
        isSelected ? Color.primaryPurple : Color.primaryYellow
    }
    var textColor : Color {
        isSelected ? .white : .black
    }
    var incomePercentage : Int {
        Int(Double(balance) / Double(income) * 100) 
    }
}
