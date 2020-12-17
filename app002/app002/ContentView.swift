//
//  ContentView.swift
//  app002
//
//  Created by 박규림 on 2020/12/17.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        
        NavigationView {
            HStack {
                NavigationLink(destination: myWebView(urlToLoad: "https://www.naver.com")
                                .edgesIgnoringSafeArea(.all)
                ){
                    Text("naver")
                        .font(.system(size : 20))
                        .fontWeight(.bold)
                        .padding(20)
                        .background(Color.green)
                        .foregroundColor(Color.white)
                        .cornerRadius(20)
                }
                NavigationLink(destination: myWebView(urlToLoad: "https://www.daum.net")
                                .edgesIgnoringSafeArea(.all)
                ){
                    Text("daum")
                        .font(.system(size : 20))
                        .fontWeight(.bold)
                        .padding(20)
                        .background(Color.orange)
                        .foregroundColor(Color.white)
                        .cornerRadius(20)
                }
                NavigationLink(destination: myWebView(urlToLoad: "https://www.google.com")
                                .edgesIgnoringSafeArea(.all)
                ){
                    Text("google")
                        .font(.system(size : 20))
                        .fontWeight(.bold)
                        .padding(20)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(20)
                }
            }
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
