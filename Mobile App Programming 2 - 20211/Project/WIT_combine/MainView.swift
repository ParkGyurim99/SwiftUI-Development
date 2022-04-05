//
//  MainView.swift
//  teamProject_pre
//
//  Created by 이재준 on 2021/05/19.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView{
            VStack {
                CircleNumberView(color: .red, number:1)
                    .navigationTitle("First Page")
                    .offset(y:-60)
                
                NavigationLink(
                    destination: SecondView(color: .green),
                    label: {
                        Text("go to subpage")
                            .bold()
                            .frame(width:280, height: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    })
            }
        }
        .accentColor(Color(.label))
    }
}

struct SecondView: View {
    
    var color:Color
    
    var body: some View {
            VStack {
                CircleNumberView(color: color, number:2)
                    .navigationTitle("SubPage of First")
                    .offset(y:-60)
                
                NavigationLink(
                    destination: ThirdView(color:.orange),
                    label: {
                        Text("go to subpage")
                            .bold()
                            .frame(width:280, height: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    })
            }
    }
}

struct ThirdView: View {
    
    var color:Color
    
    var body: some View {
            VStack {
                CircleNumberView(color: color, number:3)
                    .navigationBarTitle("subpage of sub", displayMode: .inline)
                    .offset(y:-60)
                
                Text("필요하면 사진")
                    .bold()
            }
    }
}

struct CircleNumberView: View{
    var color: Color
    var number: Int
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width:200, height: 200)
                .foregroundColor(color)
            Text("\(number)")
                .foregroundColor(.white)
                .font(.system(size:70, weight: .bold))
        }
    }
}
