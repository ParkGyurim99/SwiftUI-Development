//
//  ContentView.swift
//  app006
//
//  Created by 박규림 on 2020/12/22.
//

import SwiftUI

struct ContentView: View {
    
    // 메인 페이지 네비게이션 바 타이틀 공간 지우기 위함
    @State var isNavigationBarHidden : Bool = false
    
    var body: some View {
        
        NavigationView {
            ZStack(alignment: .bottomTrailing){
                VStack(alignment: .leading, spacing : 0) {
                    HStack {
                        NavigationLink(destination: myList(isNavigationBarHidden: self.$isNavigationBarHidden)) {
                            Image(systemName: "line.horizontal.3")
                                .font(.largeTitle)
                                .foregroundColor(.black)
                        }
                        Spacer()
                        NavigationLink(destination: myProfileView()) {
                            Image(systemName: "person.crop.circle.fill")
                            .font(.largeTitle)
                                .foregroundColor(.black)
                        }
                    }.padding(20)
                    
                    Text("To Do List")
                        .font(.system(size : 40))
                        .fontWeight(.black)
                        .padding(.horizontal, 20)
                    
                    ScrollView {
                        VStack {
                            myProjectCard()
                            myBasicCard()
                            myCard(icon: "desktopcomputer", title: "Algorithm Study", subTitle: "with Baekjoon", backgroundColor: Color.blue)
                            myCard(icon: "swift", title: "Work Out", subTitle: "Everyday", backgroundColor: Color.green)
                            myCard(icon: "play.tv.fill", title: "Netflix & Youtube", subTitle: "Chilling", backgroundColor: Color.red)
                        }.padding()
                    }
                }

                
                Circle()
                    .foregroundColor(.yellow)
                    .frame(width : 60, height: 60)
                    .overlay (
                        Image(systemName : "plus")
                            .font(.system(size : 30))
                            .foregroundColor(.white)
                    )
                    .padding(10)
                    .shadow(radius: 20)
            } // ZStack
//            .navigationBarTitle("To-do List")
            .navigationTitle("뒤로 가기")
            .navigationBarHidden(self.isNavigationBarHidden)
            .onAppear {
                self.isNavigationBarHidden = true
            }
        } // Navigation View
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
