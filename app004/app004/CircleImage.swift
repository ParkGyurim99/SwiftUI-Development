//
//  CircleImage.swift
//  app004
//
//  Created by 박규림 on 2020/12/19.
//

import SwiftUI

struct CircleImageView :  View {
    var body : some View {
//        Image(systemName : "flame.fill")
//            .font(.system(size : 200))
//            .foregroundColor(Color.blue)
//            .shadow(color: .gray, radius: 2, x: 10, y: 10)
        Image("myImage")
            .resizable() // 해상도가 크면 화면에 맞게
            .scaledToFill() // aspectRatio랑 같음. fill, fit ..
            .frame(width : 300, height: 300)
            .clipShape(Circle()) // 원 모양으로 사진 자르기
            .shadow(color: .gray, radius: 10, x: 0, y: 10)
            .overlay(
                Circle()
                    .foregroundColor(Color.black)
                    .opacity(0.2)
            )
            .overlay(Circle().stroke(Color.gray, lineWidth: 10))
//            .overlay(Circle().stroke(Color.green, lineWidth: 10).padding(12))
//            .overlay(Circle().stroke(Color.blue, lineWidth: 10).padding(24))
            .overlay(Text("COVID - 19")
                        .foregroundColor(Color.white)
                        .font(.system(size : 50))
                        .fontWeight(.heavy)
                        .shadow(color : .gray, radius: 10, x : 10, y : 10)
            )
            //.aspectRatio(contentMode: .fill) // .fill , .fit
            //.clipped()
            //.edgesIgnoringSafeArea(.all)
    }
}
