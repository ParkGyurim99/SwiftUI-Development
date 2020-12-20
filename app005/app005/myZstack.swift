//
//  myZstack.swift
//  app005
//
//  Created by 박규림 on 2020/12/20.
//

import SwiftUI

struct myZstack : View {
    var body : some View {
        ZStack {
//            Rectangle()
//                .frame(width : 150, height: 150)
//                .foregroundColor(.blue)
//
//            Rectangle()
//                .frame(width : 100, height: 100)
//                .foregroundColor(.red)
//
//            Rectangle()
//                .frame(width : 50, height: 50)
//                .foregroundColor(.yellow)
//            기본 설정은 밑에 쓸수록 화면에서 위에 (깊이가 낮다)
            
            
            // zIndex 설정 // '층'으로 이해하면 됨
            Rectangle()
                .frame(width : 50, height: 50)
                .foregroundColor(.blue)
                .zIndex(3)
            //.offset(y : -100)
            //.padding(.bottom, 10)
            
            Rectangle()
                .frame(width : 100, height: 100)
                .foregroundColor(.red)
                .zIndex(2)
            
            Rectangle()
                .frame(width : 150, height: 150)
                .foregroundColor(.yellow)
                .zIndex(1)
        }
    }
}
