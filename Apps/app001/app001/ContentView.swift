//
//  ContentView.swift
//  app001
//
//  Created by 박규림 on 2020/12/16.
//

import SwiftUI

struct ContentView: View {
    //@State 값의 변화를 감지 -> 뷰에 적용
    @State
    private var isActivated : Bool = false

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("안녕하세요!")
                        .fontWeight(.bold)
                        .font(.largeTitle)
                        .padding()
                    if !isActivated {
                        Text("PARK GYURIM\nFirst Application")
                    }
                }
                
                myPracView(isActivated: $isActivated)
                    .onTapGesture {
                        print("Cliked!") // console
                    }

                VStack {
                    Text(" 정보 ")
                        .fontWeight(.heavy)
                        .font(.system(size : 20))
                        .padding()
                        .background(Color.yellow)
                        .foregroundColor(Color.black)
                        .cornerRadius(20)
                }.onTapGesture {
                    // toggle() : true 이면 false로, false 이면 true 로 바꿔준다.
                    // self.isActivated.toggle()
            
                    // 애니메이션과 함께
                    withAnimation{
                        self.isActivated.toggle()
                    }
                }
                if isActivated {
                    Text("Version 1.0").font(.system(size : 15)).padding()
                    Text("SwiftUI").font(.system(size : 15)).padding()
                    Text("with Xcode 12.3").font(.system(size : 15)).padding()
                    NavigationLink(destination: myWebView(urlToLoad: "https://apple.co.kr")) {
                        Text("Apple.kr")
                            .font(.system(size: 15))
                            .padding()
                    }
                }
                Spacer()
                    
                // navigation button (link)
                NavigationLink(destination: myTextView(isActivated: $isActivated)) {
                    Text("시작하기")
                        .fontWeight(.heavy)
                        .font(.system(size : 20))
                        .padding()
                        .background(Color.yellow)
                        .foregroundColor(Color.black)
                        .cornerRadius(20)
                }.padding(.top, 30)
                
                Text("info Active Condition : \(String(isActivated))").padding(.top, 30)
            }
        } // navigation view
    }
}

//struct myPracView : View {
//    var body: some View {
//        HStack{
//            Color.white.fixedSize()
//            Color.blue.fixedSize()
//            Color.red.fixedSize()
//        }
//        .padding(10)
//        .background(Color.gray)
//        .cornerRadius(10)
//    }
//}


//struct ContentView2 : View {
//    var body: some View {
//        Text("안녕하세요!")
//            .fontWeight(.bold)
//            .font(.largeTitle)
//            .padding()
//        Text("Park Gyurim first Application")
//            .padding()
//    }
//}


// 보여주는 용도
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
