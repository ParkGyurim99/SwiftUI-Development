//
//  myGeometryReaderVstack.swift
//  app006
//
//  Created by 박규림 on 2020/12/29.
//

import SwiftUI

enum Index {
    case one, two, three
}

struct myGeometryReaderVstack : View {
    //operating with Button
    @State var index : Index = Index.one

    var body : some View {
        GeometryReader { geometry in
            VStack {
                Button(action : {
                    // 버튼의 액션 (클릭됐을때 로직)
                    print("Button 1 Clicked")
                    withAnimation{
                        self.index = Index.one
                    }
                })
                {   // 버튼의 생김새
                    Text("1")
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .frame(width : 100, height: geometry.size.height/3)
                        .padding(.horizontal, self.index == Index.one ? 50 : 0)
                        .foregroundColor(.white)
                        .background(Color.red)
                }
                
                
                Button(action : {
                    print("Button 2 Clicked")
                    withAnimation{
                        self.index = Index.two
                    }
                }) {
                    Text("2")
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .frame(width : 100, height: geometry.size.height/3)
                        .padding(.horizontal, self.index == Index.two ? 50 : 0)
                        .foregroundColor(.white)
                        .background(Color.blue)
                }
                
                
                Button(action : {
                    print("Button 3 Clicked")
                    withAnimation{
                        self.index = .three
                    }
                }){
                    Text("3")
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .frame(width : 100, height: geometry.size.height/3)
                        .padding(.horizontal, self.index == Index.three ? 50 : 0)
                        .foregroundColor(.white)
                        .background(Color.green)
                }
            } // Vstack
            .position(x: geometry.size.width/2, y: geometry.size.height/2)
        } // Geometry Reader
        .background(Color.yellow)
        .edgesIgnoringSafeArea(.all)
    }
}
