//
//  myProfileView.swift
//  app006
//
//  Created by 박규림 on 2020/12/28.
//

import SwiftUI

struct myProfileView : View {
    var body : some View {
        //NavigationView{
        
        ScrollView {
            VStack {
//                Image("Me")
                Image("kakao")
                    .resizable()
                    .frame(width: 196, height: 252)
                    .opacity(0.9)
                    .clipShape(Circle())
                    .shadow(color: Color.gray, radius: 10, x: 5, y: 5)
                    .overlay(
                        Circle().stroke(Color.blue, lineWidth: 10)
                    )
                    
                VStack(spacing: 5){
                    Text("Park Gyurim")
                        .fontWeight(.heavy)
                        .font(.system(size : 30))
                    Text("Daegu, Republic of Korea")
                        .fontWeight(.bold)
                    Text("+8210-7672-9902")
                        .fontWeight(.bold)
                    Text("guy021898@naver.com")
                        .fontWeight(.bold)
                    }
                .padding(.bottom, 20)
                
                HStack {
                    NavigationLink(
                        destination:
                            Image("Kakao-profile")
                                .frame(width: 300, height: 300)
                            .shadow(color: .gray, radius: 10, x: 4, y: 4)
                    ){
                        Text("KakaoTalk")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding()
                            .background(Color.yellow)
                            .cornerRadius(15)
                    }
                    
                    NavigationLink(
                        destination: myWebView(urlToLoad: "https://www.instagram.com/999rimmy/"))
                    {
                        Text("Instagram")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding()
                            .background(Color.pink)
                            .cornerRadius(15)
                    }
                }
                Spacer()
            }
        } // Scroll View
        .navigationBarTitle("My Profile")
        .navigationBarItems(trailing:
            NavigationLink(destination:
                            Text("설정 화면")
                            .font(.largeTitle)
                            .fontWeight(.black)
            ) {
                Image(systemName : "gear")
                    .font(.largeTitle)
                    .foregroundColor(.black)
            }
        )
//        } // Navigation View
            //-> contentView 에 넣을건데 이미 navigationView 로 감싸져있기때문에
            //      한번더 감싸줄 필요가 없다1!!
    } // Body
}
