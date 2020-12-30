//
//  myBlurButtonStyle.swift
//  app008
//
//  Created by 박규림 on 2020/12/31.
//

import SwiftUI

struct myBlurButtonStyle : ButtonStyle {
    var buttonColor : Color
    
    func makeBody(configuration : Configuration) -> some View {
        configuration.label
            .font(.system(size : 20))
            .foregroundColor(.white)
            .padding()
            .background(buttonColor)
            .cornerRadius(20)
            .blur(radius: configuration.isPressed ? 10 : 0)
    }
}
