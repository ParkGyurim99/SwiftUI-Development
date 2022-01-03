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
    
    @State var chatId : String = "40"
    @State var chatId2 : String = "43"
    @State var message : String = ""
    @State var message2 : String = ""
    
    var stompManager1 : StompManager = StompManager()
    var stompManager2 : StompManager = StompManager()
    
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
                }.padding(20)
                
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
                /*
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.ChatList, id : \.self) { chatroom in
                            if chatroom.message != nil { // zombie chat room
                                
                                NavigationLink(
                                    destination:
                                        ChatroomView(
                                            viewModel: ChatroomViewModel(chatroom.chatId),
                                            with: chatroom.memberTo?.username ?? "Anonymous"
                                        )
                                ) {
                                    HStack {
                                        // 1. Profile Image
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
                                        
                                        // 2. Text Area
                                        VStack(alignment : .leading, spacing : 5) {
                                            Text(chatroom.memberTo?.username ?? "Anonymous")
                                                .font(.system(size: 18, weight : .bold))
                                                .foregroundColor(.black)
                                            
                                            if let msg = chatroom.message {
                                                Text(msg.message.isEmpty ? "📷 Image" : msg.message)
                                                    .font(.system(size: 13, weight : .bold))
                                                    .foregroundColor(.gray)
                                            }
                                            
                                            Text(convertReturnedDateString(chatroom.message?.createdAt ?? "2021-10-01 00:00:00"))
                                                .font(.system(size: 12))
                                                .foregroundColor(.gray)
                                        }
                                        .padding(5)
                                        .padding(.horizontal, 5)
                                        
                                        Spacer()
                                        
                                        // 3. PostImage
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
                                    }
                                    .padding(10)
                                    .frame(width : UIScreen.main.bounds.width * 0.95)
                                    .background(Color(red: 247/255, green: 247/255, blue: 247/255)) //systemDefaultGray
                                    .cornerRadius(20)
                                    .shadow(radius: 1)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 3)
                                }
                            } // if
                        } // ForEach
                    } // LazyVStack
                } // ScrollView
                */
                
                // Socket Test
                Spacer()
                Divider()
                VStack {
                    Text("Socket - 1")
                        .bold()
                    Button("Connect") {
                        //StompManager.shared.registerSockect()
                        stompManager1.registerSockect()
                    }

                    HStack {
                        TextField("chat ID", text: $chatId)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Button("Subscribe") {
                            //StompManager.shared.subscribe(chatId: chatId)
                            stompManager1.subscribe(chatId: chatId)
                        }
                    }
                    HStack {
                        TextField("Message", text: $message)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Button("Send Message") {
                            //StompManager.shared.sendMessage(message : message)
                            stompManager1.sendMessage(message: message)
                        }
                    }
                    Button("Disconnect") {
                        //StompManager.shared.disconnect()
                        stompManager1.disconnect()
                    }
                }.padding(.horizontal, 20)
                Spacer()
                Divider()
                VStack {
                    Text("Socket - 2")
                        .bold()
                    Button("Connect") {
                        //StompManager.shared.registerSockect()
                        stompManager2.registerSockect()
                    }

                    HStack {
                        TextField("chat ID", text: $chatId)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Button("Subscribe") {
                            //StompManager.shared.subscribe(chatId: chatId)
                            stompManager2.subscribe(chatId: chatId2)
                        }
                    }
                    HStack {
                        TextField("Message", text: $message)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Button("Send Message") {
                            //StompManager.shared.sendMessage(message : message)
                            stompManager2.sendMessage(message: message2)
                        }
                    }
                    Button("Disconnect") {
                        //StompManager.shared.disconnect()
                        stompManager2.disconnect()
                    }
                }.padding(.horizontal, 20)
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
