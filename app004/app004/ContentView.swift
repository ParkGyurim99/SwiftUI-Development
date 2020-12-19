//
//  ContentView.swift
//  app004
//
//  Created by 박규림 on 2020/12/19.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Image("myImage2")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height : 20)
                    .opacity(0.3)
                
                CircleImageView()
                
                HStack {
                    NavigationLink(destination: myWebView(urlToLoad:"https://corona-live.com")) {
                        Text("코로나 라이브")
                            //.font(.system(size : 20))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding()
                            .background(Color.yellow)
                            .cornerRadius(20)
                    }
                    NavigationLink(destination: myWebView(urlToLoad:"https://m.news.naver.com/hotissue/main.nhn?sid1=102&gid=1086319&cid=1086318"))
                    {
                        Text("최신 뉴스 ")
                            //.font(.system(size : 20))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(20)
                    }
                }.padding(50)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
