//
//  ChatroomView.swift
//  stomp#1
//
//  Created by Park Gyurim on 2021/12/29.
//

import SwiftUI
import URLImage

struct ChatroomView: View {
    @StateObject private var viewModel : ChatroomViewModel
    
    @State var text : String = ""
    @State var date : String = ""
    
    var userWith : String
    
    init(viewModel : ChatroomViewModel, with user : String) {
        userWith = user
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            ScrollView {
                ScrollViewReader { proxy in
                    LazyVStack {
                        ForEach(viewModel.MessageList.reversed(), id : \.self) { message in // reversed() -> 최신순
                            HStack {
                                if let user = message.member {
                                    if user.username == userWith { // 상대방이 보낸 메시지
                                        MessageBox(message.message)
                                        Spacer()
                                    } else { // 내가 보낸 메시지
                                        Spacer()
                                        MessageBox(message.message, mine : true)
                                    }
                                } else { // Anonymous 익명 메시지
                                    MessageBox(message.message)
                                    Spacer()
                                }
                            }.id(message.message.messageId)
                        } // ForEach
                    } // LazyVStack
                    .onAppear {
                        viewModel.getChatContents(viewModel.chatId)
                        proxy.scrollTo(viewModel.lastMessageId)
                    }
                    .onChange(of: viewModel.lastMessageId) { _ in
                        withAnimation {
                            proxy.scrollTo(viewModel.lastMessageId)
                        }
                    }
                } // ScrollViewReader
            } // ScrollView
            //.padding(.horizontal, 10)
            
            // Text Bar
            HStack {
                Image(systemName : "camera")
                TextField("", text: $text)
                    .padding(.horizontal, 10)
                    .frame(minWidth: UIScreen.main.bounds.width * 0.5, maxWidth: .infinity)
                    .frame(height : UIScreen.main.bounds.height * 0.04)
                    .background(Color.white)
                    .cornerRadius(10)
                Button {
                    print("Publish message " + text)
                    viewModel.stompManager.sendMessage(message: text)
                    
                    let newMsg = Message(
                        member:
                            Sender(
                                memberId: 5,
                                username: "test",
                                description: "test",
                                profileImage: ""
                            ),
                        message:
                            MessageContents(
                                messageId: viewModel.lastMessageId + 1,
                                message: text,
                                image: "null",
                                createdAt: "\(Date(timeIntervalSinceNow: 32400))"
                            )
                    )
                    //viewModel.MessageList.append(newMsg)
                    viewModel.lastMessageId += 1
                    viewModel.MessageList.insert(newMsg, at: viewModel.MessageList.startIndex)
                    text = ""
                } label : {
                    Image(systemName : "arrow.up")
                        .padding(10)
                        .frame(height : UIScreen.main.bounds.height * 0.04)
                        .background(text.count == 0 ? Color.white : Color(red : 248/255, green : 174/255, blue : 0))
                        .foregroundColor(text.count == 0 ? .gray : .white)
                        .cornerRadius(20)
                }
            }
            .padding()
            .foregroundColor(.gray)
            .background(Color(red: 247/255, green: 247/255, blue: 247/255))
        } // VStack
        //.edgesIgnoringSafeArea(.bottom)
        .navigationTitle(Text(userWith))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(
            trailing:
                Button {
                    
                } label : {
                    Image(systemName: "ellipsis")
                }
        )
    }
}

// Each line of Message
struct MessageBox : View {
    var message : MessageContents
    var mine : Bool = false
    
    init(_ message : MessageContents) {
        self.message = message
    }
    init(_ message : MessageContents, mine : Bool) {
        self.message = message
        self.mine = mine
    }
    
    var body : some View {
        VStack(alignment : mine ? .trailing : .leading, spacing : 3) {
            VStack(alignment : .trailing) {
                if message.message != "" {
                    Text(message.message)
                }
                if message.image != "null" {
                    URLImage(
                        URL(string : message.image)!
                    ) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth : UIScreen.main.bounds.width * 0.6)
                    }.cornerRadius(10)
                }
            }
            .padding()
            .background(Color(red: 247/255, green: 247/255, blue: 247/255))
            .cornerRadius(10)
        
            Text(convertReturnedDateString(message.createdAt))
                .foregroundColor(.black.opacity(0.7))
                .font(.system(size : 10))
        }.padding(.horizontal, 10)
    }
}
