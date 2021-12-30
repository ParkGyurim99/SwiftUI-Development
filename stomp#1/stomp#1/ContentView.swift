//
//  ContentView.swift
//  stomp#1
//
//  Created by Park Gyurim on 2021/12/27.
//

import SwiftUI
import Alamofire
import URLImage

// 채팅방이 생성되고 채팅이 보내지지 않은 채팅방,, 좀비 채팅방 처리 ? 백 or 프론트
// 익명채팅간에 수신자 발신자

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                // Title
                HStack {
                    Text("Chatting")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                    Image(systemName : "bell.fill")
                }.padding(.horizontal, 20)
                
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
                            if chatroom.message != nil {
                                
                                NavigationLink(
                                    destination:
                                        ChatroomView(viewModel: ChatroomViewModel(chatroom.chatId), with: chatroom.memberTo?.username ?? "Anonymous")
                                ) {
                                    HStack {
                                        // Image
                                        URLImage(
                                            URL(string : chatroom.memberTo?.profileImage ?? "https://www.gravatar.com/avatar/3b37be7c3ac00a1237fe8d4252fd4540.jpg?size=240&d=https%3A%2F%2Fwww.artstation.com%2Fassets%2Fdefault_avatar.jpg")!
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
                                        VStack(alignment : .leading, spacing : 5) {
                                            Text(chatroom.memberTo?.username ?? "Anonymous")
                                                .font(.system(size: 16, weight : .bold))
                                                .foregroundColor(.black)
                                            Spacer()
                                            Text(chatroom.message?.message ?? "Unknown")
                                                .font(.system(size: 13, weight : .bold))
                                                .foregroundColor(.gray)
                                            Text(convertReturnedDateString(chatroom.message?.createdAt ?? "2021-10-01 00:00:00"))
                                                .font(.system(size: 13))
                                                .foregroundColor(.gray)
                                        }
                                        .padding(5)
                                        .padding(.horizontal, 5)
                                        
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
                                
                            }
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
            .navigationBarHidden(true)
            .navigationTitle(Text(""))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
