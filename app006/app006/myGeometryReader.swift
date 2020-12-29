//
//  myGeometryReader.swift
//  app006
//
//  Created by 박규림 on 2020/12/29.
//

import SwiftUI

struct myGeometryReader : View {
    //operating with OnTapGesture
    @State var tapGesture1 : Bool = false
    @State var tapGesture2 : Bool = false
    @State var tapGesture3 : Bool = false
    
    var body : some View {
        GeometryReader { geometryreader in
            VStack(spacing : 0) {
                Text("1")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .frame(width : tapGesture1 ? geometryreader.size.width / 4 : 30
                           ,height : geometryreader.size.height / 3)
                    .foregroundColor(.white)
                    .background(Color.red)
                    .onTapGesture {
                        withAnimation {
                            self.tapGesture1.toggle()
                            self.tapGesture2 = false
                            self.tapGesture3 = false
                        }
                    }
                Text("2")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .frame(width : tapGesture2 ? geometryreader.size.width / 4 : 30
                           ,height : geometryreader.size.height / 3)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .onTapGesture {
                        withAnimation {
                            self.tapGesture2.toggle()
                            self.tapGesture1 = false
                            self.tapGesture3 = false                        }
                    }
                Text("3")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .frame(width : tapGesture3 ? geometryreader.size.width / 4 : 30
                           ,height : geometryreader.size.height / 3)
                    .foregroundColor(.white)
                    .background(Color.green)
                    .onTapGesture {
                        withAnimation {
                            self.tapGesture3.toggle()
                            self.tapGesture2 = false
                            self.tapGesture1 = false                        }
                    }
            } // VStack
            //.background(Color.black)
            .position(x: geometryreader.size.width/2, y: geometryreader.size.height/2)
        } // Geometry Reader
        .background(Color.yellow)
        .edgesIgnoringSafeArea(.all)
    }
}
