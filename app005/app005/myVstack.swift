//
//  myVstack.swift
//  app005
//
//  Created by 박규림 on 2020/12/20.
//

import SwiftUI

struct myVstack : View {
    var body: some View {
        VStack(alignment : .trailing, spacing : 0) {
            //Divider().opacity(0)
            //Rectangle().frame(height : 0)
            // 2-> alignment 설정시 각 요소 내에서 정렬이 아니라 스택 안에서 정렬을 시키려고 할때 필요함
            
//            Spacer()
            
            Text("글자")
                .font(.system(size : 30))
                .fontWeight(.heavy)
                //.padding(.bottom, 50)
            Rectangle()
                .frame(width : 100, height: 100)
                .foregroundColor(.red)
                //.padding(.vertical, 50)
            Rectangle()
                .frame(width : 100, height: 100)
                .foregroundColor(.yellow)
            
            Spacer().frame(height : 50)
            
            Rectangle()
                .frame(width : 100, height: 100)
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            
//            Spacer()
//            Spacer()
//            Spacer() // 스페이서 종류에 따라서 비율 처리 가능
        }//.ignoresSafeArea(.all)
        .frame(width : 300)
        .background(Color.green)
    }
}
