//
//  myCustomTabView.swift
//  app006
//
//  Created by 박규림 on 2020/12/30.
//

import SwiftUI

enum tabIndex {
//    case home
//    case profile
//    case cart
    case home, profile, cart
}

struct myCustomTabView : View {
    @State var tIndex : tabIndex
    @State var largerScale : CGFloat = 1.4 // 크기 관련된거 할땐 CGFloat 자료형
    
    func changeMyView(tIndex : tabIndex) -> myView{
        switch tIndex {
        case tabIndex.home :
            return myView(titleText: "홈", bgColor: Color.green)
        case tabIndex.cart :
            return myView(titleText: "장바구니", bgColor: Color.purple)
        case tabIndex.profile :
            return myView(titleText: "프로필", bgColor: Color.blue)
        }
    }
    
    func changeIconColor(tIndex : tabIndex) -> Color {
        switch tIndex {
        case tabIndex.home :
            return Color.green
        case tabIndex.cart :
            return Color.purple
        case tabIndex.profile :
            return Color.blue
        }
    }
    
    func calcCircleBgPosition(tIndex : tabIndex, geometry : GeometryProxy) -> CGFloat {
        switch tIndex {
        case .home :
            return -(geometry.size.width / 3)
        case .cart :
            return 0
        case .profile :
            return geometry.size.width / 3
        }
    }
    
    var body : some View {
        GeometryReader { geometry in
            ZStack(alignment : .bottom) {
                self.changeMyView(tIndex: self.tIndex)
                
                Circle()
                    .frame(width: 90, height: 90)
                    .offset(x : self.calcCircleBgPosition(tIndex: tIndex, geometry: geometry), y : UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 15 : 0)
                    .foregroundColor(.white)
                    
                VStack(spacing : 0) {
                    HStack(spacing : 0) {
                        Button(action : {
                            withAnimation {
                                self.tIndex = .home
                            }
                            print("home button clicked!")
                        }) {
                            Image(systemName : "house.fill")
                                .font(.system(size : 25))
                                .scaleEffect(self.tIndex == .home ? self.largerScale : 1.0)
                                .foregroundColor(self.tIndex == tabIndex.home ? self.changeIconColor(tIndex: self.tIndex) : Color.gray)
                                .frame(width : geometry.size.width / 3, height: 50)
                                .offset(y : self.tIndex == .home ? -10 : 0)
                        }.background(Color.white)
                        
                        Button(action : {
                            withAnimation {
                                self.tIndex = .cart
                            }
                            print("cart button click  ed!")
                        }) {
                            Image(systemName : "cart.fill")
                                .font(.system(size : 25))
                                .scaleEffect(self.tIndex == .cart ? self.largerScale : 1.0)
                                .foregroundColor(self.tIndex == tabIndex.cart ? self.changeIconColor(tIndex: self.tIndex) : Color.gray)
                                .frame(width : geometry.size.width / 3, height: 50)
                                .offset(y : self.tIndex == .cart ? -10 : 0)
                        }.background(Color.white)
                        
                        Button(action : {
                            withAnimation {
                                self.tIndex = .profile
                            }
                            print("profile button clicked!")
                        }) {
                            Image(systemName : "person.circle.fill")
                                .font(.system(size : 25))
                                .scaleEffect(self.tIndex == .profile ? self.largerScale : 1.0)
                                .foregroundColor(self.tIndex == tabIndex.profile ? self.changeIconColor(tIndex: self.tIndex) : Color.gray)
                                .frame(width : geometry.size.width / 3, height: 50)
                                .offset(y : self.tIndex == .profile ? -10 : 0)
                        }.background(Color.white)
                    } // HStack
                    
                    Rectangle() // 풀 스크린 아이폰 에서 밑에 Bar랑 안겹치게 하기 위해서 !
                        //.frame(height : 20)
                        .frame(height :  UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 0 : 20)
                        //UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 --> 구형 아이폰 (풀스크린 x)
                        .foregroundColor(Color.white)
                } // VStack
                
                
            } // ZStack
        }.edgesIgnoringSafeArea(.all)
    }
}
