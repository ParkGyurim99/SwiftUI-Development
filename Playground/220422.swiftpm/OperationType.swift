//
//  OperationType.swift
//  Fundamental Arithmetics
//
//  Created by Park Gyurim on 2022/04/24.
//

import Foundation

enum OperationType : String, CaseIterable {
    case Plus
    case Minus
    case Multiply
    case Divide
    
    func title() -> String {
        switch self {
            case .Plus : return "Addition"
            case .Minus : return "Substraction"
            case .Multiply : return "Multiplication"
            case .Divide : return "Division"
        }
    }
    
    func emoji() -> String {
        switch self {
            case .Plus : return "➕"
            case .Minus : return "➖"
            case .Multiply : return "✖️"
            case .Divide : return "➗"
        }
    }
}
