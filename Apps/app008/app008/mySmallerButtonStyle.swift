//
//  mySmallerButtonStyle.swift
//  app008
//
//  Created by 박규림 on 2020/12/31.
//

import SwiftUI

struct mySmallerButtonStyle : ButtonStyle {
    var buttonColor : Color
    
    func makeBody(configuration : Configuration) -> some View {
        configuration.label
            .font(.system(size : 20))
            .foregroundColor(.white)
            .padding()
            .background(buttonColor)
            .cornerRadius(20)
            .scaleEffect(configuration.isPressed ? 0.8 : 1.0)
            .opacity(configuration.isPressed ? 0.5 : 1.0)
    }
}
