//
//  Extensions.swift
//  KeyboardObserver
//
//  Created by Park Gyurim on 2022/04/17.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}
