//
//  ContentView.swift
//  stomp#1
//
//  Created by Park Gyurim on 2021/12/27.
//

import SwiftUI
import Alamofire
import URLImage

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .padding(.horizontal, 3)
                    Text("Search")
                        .font(.system(size : 14))
                    Spacer()
                }
                .foregroundColor(.gray)
                .frame(
                    width: UIScreen.main.bounds.width * 0.95,
                    height : UIScreen.main.bounds.height * 0.035
                )
                .background(Color(red: 247/255, green: 247/255, blue: 247/255))
                .cornerRadius(15)
                
                // Chat list
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.ChatList, id : \.self) { chatroom in
                            NavigationLink(
                                destination:
                                    Text("Chatroom \(chatroom.chatId)")
                            ) {
                                HStack {
                                    // Image
                                    URLImage(
                                        URL(string : chatroom.memberTo?.profileImage ?? "https://static.thenounproject.com/png/741653-200.png")!
                                    ) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                    }
                                    .frame(
                                        width : UIScreen.main.bounds.width * 0.16,
                                        height: UIScreen.main.bounds.width * 0.16
                                    )
                                    .clipShape(Circle())
                                    .shadow(radius : 1)
                                    .padding(.horizontal, 5)
                                    
                                    // Text
                                    VStack(alignment : .leading) {
                                        Text(chatroom.memberTo?.username ?? "Unknown")
                                            .font(.system(size: 16, weight : .bold))
                                            .foregroundColor(.black)
                                        Spacer()
                                        Text(chatroom.message?.message ?? "Unknown")
                                            .font(.system(size: 14))
                                            .foregroundColor(.gray)
                                        Text(chatroom.message?.createdAt.substring(to: (chatroom.message?.createdAt.index((chatroom.message?.createdAt.startIndex)!, offsetBy: 10))!) ?? "Unknown")
                                            .font(.system(size: 14))
                                            .foregroundColor(.gray)
                                    }
                                    .padding(10)
                                    
                                    Spacer()
                                    
                                    // PostImage
                                    URLImage(
                                        URL(string : chatroom.post.image)!
                                    ) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                    }
                                    .frame(
                                        width : UIScreen.main.bounds.width * 0.25,
                                        height: UIScreen.main.bounds.width * 0.2
                                    )
                                    .cornerRadius(20)
                                    //.shadow(radius : 1)
                                }
                                .padding(10)
                                .frame(width : UIScreen.main.bounds.width * 0.95)
                                .background(Color(red: 247/255, green: 247/255, blue: 247/255)) //systemDefaultGray
                                .cornerRadius(20)
                                .shadow(radius: 1)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 3)
                            }//.buttonStyle(.plain)
                        } // Foreach
                    } // LazyVStack
                } // ScrollView
                
                
                // Socket Test
                Spacer()
                Divider()
                Text("Socket")
                    .bold()
                Button("Connect") {
                    StompManager.shared.registerSockect()
                }
                Button("Send Message") {
                    StompManager.shared.sendMessage()
                }
                Button("Disconnect") {
                    StompManager.shared.disconnect()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(Text("Message"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
