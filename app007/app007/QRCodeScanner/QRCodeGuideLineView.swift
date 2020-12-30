//
//  QRCodeGuideLineView.swift
//  app007
//
//  Created by 박규림 on 2020/12/30.
//

import SwiftUI

struct QRCodeGuideLineView : View {
    var body : some View {
        GeometryReader { geometry in
            Text("Swipe Down to Previous Page")
                .font(.system(size : 20))
                .fontWeight(.black)
                .foregroundColor(.yellow)
                .position(x : geometry.size.width / 2, y : geometry.size.height / 4)
            RoundedRectangle(cornerRadius : 20)
                .stroke(style: StrokeStyle(lineWidth : 10, dash : [12]))
                .frame(width : geometry.size.width / 2 , height : geometry.size.width / 2)
                .position(x : geometry.size.width / 2, y : geometry.size.height / 2)
        }
    }
}
