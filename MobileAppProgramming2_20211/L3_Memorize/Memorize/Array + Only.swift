//
//  Array + Only.swift
//  Memorize
//
//  Created by Park Gyurim on 2021/04/02.
//

import Foundation

extension Array {
    var only : Element? {
        count == 1 ? first : nil
    }
}
