//
//  DropdownItemProtocol.swift
//  Increment
//
//  Created by Park Gyurim on 2021/08/25.
//

import Foundation

protocol DropdownItemProtocol {
    var options : [DropdownOption] { get }
    var headerTitle : String { get }
    var dropdownTitle : String { get }
    var isSelected : Bool { get set }
}

protocol DropdownOptionProtocol {
    var toDropdownOption : DropdownOption { get }
}


struct DropdownOption {
    enum DropdownOptionType {
        case text(String)
        case number(Int)
    }
    
    let type : DropdownOptionType
    let formatted : String
    var isSelected : Bool
}


