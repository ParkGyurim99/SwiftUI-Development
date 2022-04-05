//
//  UIDevice+Extension.swift
//  stomp#1
//
//  Created by Park Gyurim on 2022/03/02.
//

import Foundation
import UIKit

extension UIDevice {
    var hasNotch: Bool {
        let bottom = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
    // EX) SomeView().background(UIDevice.current.hasNotch ? Color.red : Color.yellow)
}
