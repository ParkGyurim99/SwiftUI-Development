//
//  myNavigationView.swift
//  app006
//
//  Created by 박규림 on 2020/12/28.
//
// not used in app

import SwiftUI

struct myNavigationView : View {
    var body : some View {
        NavigationView {
            VStack {
                Image("Me")
                    .resizable()
                    .frame(width: 210, height: 270)
                    .opacity(0.9)
                    .clipShape(Circle())
                    .shadow(color: Color.gray, radius: 10, x: 5, y: 5)
                    .overlay(
                        Circle().stroke(Color.blue, lineWidth: 8)
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
                        destination: myWebView(urlToLoad: "https://www.instagram.com/999rimmy/"))
                    {
                        Text("Instagram")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.pink)
                            .cornerRadius(15)
                    }
                    NavigationLink(
                        destination:
                            Image("Kakao-profile")
                                .frame(width: 300, height: 300)
                            .shadow(color: .gray, radius: 10, x: 4, y: 4)
                    ){
                        Text("KakaoTalk")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.yellow)
                            .cornerRadius(15)
                    }
                }
                Spacer()
            }
        } // Navigation View
        .navigationTitle("내 프로필")
        .navigationBarItems(trailing:
                                NavigationLink(destination:
                                    Text("설정 화면")
                                        .font(.largeTitle)
                                        .fontWeight(.black)
                                                     )
                                {
                                    Image(systemName : "gear")
                                        .font(.largeTitle)
                                        .foregroundColor(.black)
                                }
        )
    }
}
