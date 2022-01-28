//
//  MyPageView.swift
//  Nanuri
//
//  Created by Park Gyurim on 2022/01/28.
//

import SwiftUI

struct MyPageView: View {
    @State var isProfileCliked : Bool = false
    
    var Title : some View {
        HStack {
            Text("My Page")
                .font(.largeTitle)
                .fontWeight(.bold)
                //.frame(maxWidth : .infinity, alignment: .leading)
            Spacer()
            Image(systemName: "gearshape.fill")
                .font(.system(size: 25))
        }
    }
    var Profile : some View {
        VStack {
            Divider()
            Button {
                isProfileCliked = true
            } label: {
                HStack {
                    Image(systemName: "person.fill")
                        .font(.system(size: 25))
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.darkGray)
                        .clipShape(Circle())
                    
                    VStack(alignment : .leading, spacing : 10) {
                        Text("User Name")
                            .font(.system(.title2, design: .rounded))
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                        Text("User Description")
                            .font(.system(.subheadline, design: .rounded))
                            .foregroundColor(.gray)
                    }.padding(.leading, 10)
                    Spacer()
                }.padding(.vertical, 10)
            }
            Divider()
        }.padding(.bottom, 20)
    }
    
    var body: some View {
        VStack {
            Title
            Profile
            
            Text("My Classes (#)")
                .font(.system(.title3, design: .rounded))
                .fontWeight(.semibold)
                .frame(maxWidth : .infinity, alignment: .leading)
                
            ScrollView(.horizontal) {
                HStack {
                    ForEach(0..<3, id : \.self) { _ in
                        Color.gray
                            .opacity(0.5)
                            .frame(width: 120, height: 120)
                            .cornerRadius(20)
                    }
                }
            }
            Spacer()
                .frame(height : 50)
            Divider()
                Text("내가 신청한 클래스")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
            Spacer()
            
        } // VStack
        .padding()
        .navigationBarHidden(true)
        .sheet(isPresented: $isProfileCliked) { Text("Profile") }
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView()
    }
}
