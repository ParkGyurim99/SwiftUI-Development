//
//  TextFieldCustomRoundedStyle.swift
//  Increment
//
//  Created by Park Gyurim on 2021/09/05.
//

import SwiftUI

struct TextFieldCustomRoundedStyle : ViewModifier {
    func body(content : Content) -> some View {
        return content
            .font(.system(size : 16, weight : .medium))
            .foregroundColor(.primary)
            .padding()
            .cornerRadius(15)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.primary)
            )
            .padding(.horizontal, 15)
    }
}
