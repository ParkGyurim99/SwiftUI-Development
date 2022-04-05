//
//  PrimaryButtonStyle.swift
//  Increment
//
//  Created by Park Gyurim on 2021/08/24.
//

import SwiftUI

struct PrimaryButtonStyle : ButtonStyle { // ButtonStyle -> Protocol,,, have to implement 'makeBody' function
    var fillColor : Color = .darkPrimaryButton
    
    func makeBody(configuration: Configuration) -> some View {
        return
            PrimaryButton(
                configuration : configuration,
                fillColor: fillColor
            )
    }
    
    struct PrimaryButton : View {
        let configuration : Configuration
        let fillColor : Color
        
        var body : some View {
            return configuration.label
                .padding(20)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(fillColor)
                )
                
        }
    }
}

struct PrimaryButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button(action : {}) {
            Text("Create a challenge")
        }.buttonStyle(PrimaryButtonStyle())
    }
}
