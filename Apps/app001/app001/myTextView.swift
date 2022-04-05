//
//  myTextView.swift
//  app001
//
//  Created by 박규림 on 2020/12/17.
//

import SwiftUI

struct myTextView : View {
    @State
    private var index : Int = 0

    @Binding
    var isActivated : Bool
    
    init(isActivated : Binding<Bool> = .constant(true)) {
        _isActivated = isActivated
    }
    
    // background color array
    private let backgroundColors = [
        Color.red,
        Color.orange,
        Color.yellow,
        Color.green,
        Color.blue
    ]
    
    var body : some View {
        VStack {
            //Spacer()
            Text("배경 아이템 인덱스 \(self.index)")
                .font(.system(size : 30))
                .fontWeight(.bold)
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                       minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            Text("Info Active Condition : \(String(isActivated))")
            myPracView(isActivated: $isActivated)
            //Spacer()
        }.background(backgroundColors[index])
        .edgesIgnoringSafeArea(.all)
        .onTapGesture {
            withAnimation {
                print("배경 아이템이 클릭됨")
                if self.index == self.backgroundColors.count - 1 {
                    self.index = 0
                } else {
                    self.index += 1
                }
//                if index == 4 {
//                    index = -1
//                }
//                index += 1
            }
            
        }
    }
}
