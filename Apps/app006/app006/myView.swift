//
//  myView.swift
//  app006
//
//  Created by 박규림 on 2020/12/29.
//

import SwiftUI

struct myView : View {
    var titleText : String
    var bgColor : Color
    
    var body : some View {
        ZStack {
            bgColor
                //.edgesIgnoringSafeArea(.all)

            Text(titleText)
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundColor(.white)
        }.animation(.none) // 이 뷰에서 애미네이션을 주고 싶지 않을때!
    }
}
