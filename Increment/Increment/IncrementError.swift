//
//  IncrementError.swift
//  Increment
//
//  Created by Park Gyurim on 2021/08/30.
//

import Foundation

// custom error
enum IncrementError : LocalizedError {
    case auth(description : String) // firebase error and will alert
    case `default`(description : String? = nil) // ' ` ?
    
    var errorDescription: String? {
        switch self {
        case let .auth(description) :
            return description
        case let .default(description) :
            return description ?? "Something went wrong"
        }
    }
}
