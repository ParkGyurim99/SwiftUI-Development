//
//  Cardify.swift
//  Memorize
//
//  Created by Park Gyurim on 2021/04/09.
//

import SwiftUI

struct Cardify : ViewModifier {
    var isFaceUp : Bool
    
    func body(content : Content) -> some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: endLineWidth)
                content
            }
            else {
                RoundedRectangle(cornerRadius: cornerRadius).fill()
            }
        }
    }
    
    private let cornerRadius : CGFloat = 10.0
    private let endLineWidth : CGFloat = 3
}

extension View {
    func cardify(isFaceUp : Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
