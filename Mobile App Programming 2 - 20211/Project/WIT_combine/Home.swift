//
//  Home.swift
//  teamProject_pre
//
//  Created by 이재준 on 2021/05/22.
//

import SwiftUI

struct Home : View {
    @State var width = UIScreen.main.bounds.width - 90
    @State var x = -UIScreen.main.bounds.width + 90
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)){
            HomePage(x: $x)
            SlideView()
                .shadow(color: Color.black.opacity(x != 0 ? 0.1 : 0), radius: 5, x:5, y:0)
                .offset(x:x)
                .background(Color.black.opacity(x == 0 ? 0.5 : 0).ignoresSafeArea(.all, edges: .vertical).onTapGesture {
                    withAnimation {
                        x = -width
                    }
                })
        }
        .navigationBarBackButtonHidden(true)
        .gesture(DragGesture().onChanged({ (value) in
            withAnimation{
                if value.translation.width > 0 {
                    if x < 0 {
                        x = -width + value.translation.width
                    }
                }
                else {
                    if x != -width {
                        x = value.translation.width
                    }
                }
            }
        }).onEnded({ (value) in
            withAnimation{
                if -x < width / 2 {
                    x = 0
                }
                else {
                    x = -width
                }
            }
        }))
    }
}


struct HomePage : View {
    @State var tabIndex : Int = 1
    @State var largerScale : CGFloat = 1.4

    @Binding var x : CGFloat
    
    var bgColor : Color = .gray
    
    
    func CirclePosition(tabIndex : Int, geometry : GeometryProxy) -> CGFloat {
        switch tabIndex {
        case 1 :
            return -(geometry.size.width / 3)
        case 2 :
            return 0
        case 3 :
            return geometry.size.width / 3
        default:
            return 0
        }
    }
    var body: some View {
        GeometryReader { geometry in
            let colWidth = geometry.size.width / 3
            
            VStack {
                NavView(colWidth: colWidth, x:$x)
                ZStack(alignment : .bottom) {
                    switch (tabIndex) {
                    case 1 : TimeLineView(colWidth:colWidth).navigationBarHidden(true).padding(.bottom, 80)
                    case 2 : categoryView().padding(.bottom, 90)
                    case 3 : ProfileView().navigationBarHidden(true).padding(.bottom, 100)
                    default:
                        TimeLineView(colWidth:colWidth).navigationBarHidden(true).padding(.bottom, 90)
                    }
                    
                    Circle()
                        .frame(width: 90, height: 90)
                        .offset(x : self.CirclePosition(tabIndex: tabIndex, geometry: geometry), y : 10)
                        .foregroundColor(bgColor)
                        .padding(20)
                        
                    VStack(spacing : 0) {
                        HStack(spacing : 0) {
                            Button(action : {
                                withAnimation {
                                    self.tabIndex = 1
                                }
                            }) {
                                Image(systemName : "house.fill")
                                    .foregroundColor(.white)
                                    .font(.system(size : 25))
                                    .scaleEffect(self.tabIndex == 1 ? self.largerScale : 1.0)
                                    .frame(width : geometry.size.width / 3, height: 50)
                                    .offset(y : self.tabIndex == 1 ? -10 : 0)
                                    .shadow(color: Color.black.opacity(0.1), radius: 5, x:0, y:5)
                                    .shadow(color: Color.black.opacity(0.08), radius: 5, x:0, y:-5)
                            }.background(bgColor)
                            Button(action : {
                                withAnimation {
                                    self.tabIndex = 2
                                }
                            }) {
                                Image(systemName: "square.grid.3x3.fill")
                                    .foregroundColor(.white)                                    .font(.system(size : 25))
                                    .scaleEffect(self.tabIndex == 2 ? self.largerScale : 1.0)
                                    .frame(width : geometry.size.width / 3, height: 50)
                                    .offset(y : self.tabIndex == 2 ? -10 : 0)
                                    .shadow(color: Color.black.opacity(0.1), radius: 5, x:0, y:5)
                                    .shadow(color: Color.black.opacity(0.08), radius: 5, x:0, y:-5)
                            }.background(bgColor)
                            Button(action : {
                                withAnimation {
                                    self.tabIndex = 3
                                }
                            }) {
                                Image(systemName : "person.circle.fill")
                                    .foregroundColor(.white)                                    .font(.system(size : 25))
                                    .scaleEffect(self.tabIndex == 3 ? self.largerScale : 1.0)
                                    .frame(width : geometry.size.width / 3, height: 50)
                                    .offset(y : self.tabIndex == 3 ? -10 : 0)
                                    .shadow(color: Color.black.opacity(0.1), radius: 5, x:0, y:5)
                                    .shadow(color: Color.black.opacity(0.08), radius: 5, x:0, y:-5)
                            }.background(bgColor)
                        } // HStack
                        .padding(.bottom, 10)
                        Spacer()
                            .frame(height : 20)
                            .background(bgColor)
                    }
                    .background(bgColor)
                }
                .edgesIgnoringSafeArea(.bottom)
            }
        }
    }
}
