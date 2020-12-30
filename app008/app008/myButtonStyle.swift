//
//  myButtonStyle.swift
//  app008
//
//  Created by 박규림 on 2020/12/31.
//

import SwiftUI

enum ButtonType {
    case tab, long
}

struct myButtonStyle : ButtonStyle {
    var buttonColor : Color
    var type : ButtonType
    
    func makeBody(configuration : Configuration) -> some View {
        configuration.label
            .font(.system(size : 20))
            .foregroundColor(.white)
            .padding()
            .background(buttonColor)
            .cornerRadius(20)
            .scaleEffect(configuration.isPressed ? 1.3 : 1.0)
            .onTapGesture {
                if self.type == .tab {
                    let haptic = UIImpactFeedbackGenerator(style: .light)
                    haptic.impactOccurred()
                }
            }.onLongPressGesture {
                if self.type == .long {
                    let haptic = UIImpactFeedbackGenerator(style: .heavy)
                    haptic.impactOccurred()
                }
            }
    }
}
