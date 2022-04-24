//
//  ContentModel.swift
//  220422
//
//  Created by Park Gyurim on 2022/04/23.
//

import SwiftUI

enum AlertType {
    case Success
    case Fail
}

struct Device {
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
    
    static let halfWidth = UIScreen.main.bounds.width / 2
}

struct CardInfo {
    var number : Int = 1
    var position : CGSize
    var scale : CGFloat = 1.0
    var opacity : CGFloat = 1.0
    
    init(x : CGFloat, y : CGFloat) { position = .init(width: x, height: y) }
}
