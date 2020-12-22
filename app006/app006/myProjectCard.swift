//
//  myProjectCard.swift
//  app006
//
//  Created by 박규림 on 2020/12/23.
//

import SwiftUI

struct myProjectCard : View {
    
    @State
    var shouldShowAlert : Bool = false
    
    var body : some View {
        VStack(alignment: .leading, spacing : 0){
            //Rectangle().frame(height : 0) // 가득 채우기 용
            Text("IOS App Development")
                .font(.system(size : 23))
                .fontWeight(.black)
                .padding(.bottom, 5)
            Text("2020/12/23 WED.")
                .foregroundColor(.secondary) //회색
                .padding(.bottom, 10)
            HStack {
                Image("instagram")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    
                Image("kakao")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(lineWidth: 3)
                            .foregroundColor(Color.gray)
                    )
                Image("naver")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                Spacer()
                
                
                
                Button(action : {
                    print("Clicked")
                    self.shouldShowAlert = true
                }){ // 생김새
                    Text("확인")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width : 80)
                        .background(Color.blue)
                        .cornerRadius(20)
                }.alert(isPresented: $shouldShowAlert) {
                    Alert(title: Text("clicked!"))
                }
            }
        }
        .padding(30)
        .background(Color.yellow)
        .cornerRadius(20)
        
    }
}
