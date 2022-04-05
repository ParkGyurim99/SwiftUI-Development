//
//  myTapView.swift
//  app006
//
//  Created by 박규림 on 2020/12/29.
//

import SwiftUI

struct myTabView : View {
    var body : some View {
        TabView {
            // 보여질 화면
//            Text("1")
//                .font(.largeTitle)
//                .fontWeight(.black)
//                .tabItem {
//                    Image(systemName : "airplane")
//                    Text("1번")
//                }
//                .tag(0)
            myView(titleText: "홈", bgColor: Color.green)
                .tabItem {
                    Image(systemName : "house.fill")
                    Text("홈")
                }.tag(0)
            myView(titleText: "장바구니", bgColor: Color.purple)
                .tabItem {
                    Image(systemName : "cart.fill")
                    Text("장바구니")
                }.tag(1)
            myView(titleText: "프로필", bgColor: Color.blue)
                .tabItem {
                    Image(systemName : "person.crop.circle.fill")
                    Text("프로필")
                }.tag(2)
        }
    }
}
