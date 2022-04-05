//
//  SlideView.swift
//  teamProject_pre
//
//  Created by 이재준 on 2021/05/19.
//

import SwiftUI
import FirebaseAuth
import SDWebImageSwiftUI

struct SlideView : View {
    @EnvironmentObject var session : SessionStore
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    @State var show = true
    
    var body: some View {
        HStack(spacing: 0){
            VStack(alignment: .leading){
                Spacer()
                    .frame(height : 40)
                HStack {
                    WebImage(url: URL(string:Auth.auth().currentUser?.photoURL!.absoluteString ?? "https://karateinthewoodlands.com/wp-content/uploads/2017/09/default-user-image.png")!)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x:0, y:5)
                        .shadow(color: Color.black.opacity(0.08), radius: 5, x:0, y:-5)
                    Text("\(Auth.auth().currentUser?.displayName ?? "undefined")") //username
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding(.leading)
                }.padding(.leading)

                Divider()
                    .padding(.vertical, 10)
                
                VStack(alignment: .leading){
                    
                    ForEach(menuButtons, id: \.self) {menu in
                        Button(action: {
                        }){
                            MenuButton(title: menu)
                                .padding(.leading)
                        }
                    }
                    
                    Divider()
                        .padding(.top)
                    
                    Button(action: session.logout){
                        Text("Log Out")
                            .foregroundColor(Color.black)
                            .bold()
                    }
                    .padding(.leading)
                    .padding(.vertical, 20)
                    
                    Spacer(minLength: 0)
                    
                    Divider()
                        .padding(.bottom)
                    
                    HStack {
                        Spacer()
                        VStack{
                            Text("copyrightⓒ")
                            Text("2021 All rights reserved by WIT")
                        }
                        Spacer()
                    }
                }
                .opacity(show ? 1: 0)
                .frame(height: show ? nil : 0)
                
                VStack(alignment: .leading){
                    
                    Button(action: {}){
                        Text("Log Out")
                            .foregroundColor(Color.black)
                            .padding(.leading)
                    }
                    
                    Spacer(minLength: 0)
                }
                .opacity(show ? 0: 1)
                .frame(height: show ? 0 : nil)
            }
            .padding(.horizontal, 20)
            .padding(.top,edges!.top == 0 ? 15 : edges?.top)
            .padding(.bottom,edges!.bottom == 0 ? 15 : edges?.bottom)
            .frame(width: UIScreen.main.bounds.width - 90)
            .background(Color.white)
            .ignoresSafeArea(.all, edges: .vertical)
            
            Spacer(minLength: 0)
        }
    }
}

struct FollowView : View {
    var count: Int
    var title: String
    
    var body: some View {
        HStack{
            Text("\(count)")
                .fontWeight(.bold)
                .foregroundColor(.black)
            
            Text(title)
                .foregroundColor(.gray)
        }
    }
}

var menuButtons = ["Timeline", "Closet", "Profile"]

struct MenuButton : View {
    var title : String
    
    var body : some View {
        
        HStack(spacing: 15){
            
            
            Text(title)
                .foregroundColor(.black)
            
            Spacer(minLength: 0)
        }
        .padding(.vertical, 12)
    }
}
