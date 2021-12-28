//
//  ChatroomView.swift
//  stomp#1
//
//  Created by Park Gyurim on 2021/12/29.
//

import SwiftUI

struct ChatroomView: View {
    @StateObject private var viewModel : ChatroomViewModel
    
    @State var text : String = ""
    
    var userWith : String
    
    init(viewModel : ChatroomViewModel, with user : String) {
        userWith = user
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.MessageList.reversed(), id : \.self) { message in // reversed() -> 최신순
                        HStack {
                            if message.member.username != userWith { // 내가 보낸 메시지
                                Spacer()
                                Text(message.message.message)
                                    .padding()
                                    .background(Color(red: 247/255, green: 247/255, blue: 247/255))
                                    .cornerRadius(10)
                            } else { // 상대가 보낸 메시지
                                Text(message.message.message)
                                    .padding()
                                    .background(Color(red: 247/255, green: 247/255, blue: 247/255))
                                    .cornerRadius(10)
                                Spacer()
                            }
                        }
                    }
                } // LazyVStack
            } // ScrollView
            .padding(.horizontal, 10)
            
            // Text Bar
            HStack {
                Image(systemName : "camera")
                TextField("", text: $text)
                    .padding(.horizontal, 10)
                    .frame(minWidth: UIScreen.main.bounds.width * 0.5, maxWidth: .infinity)
                    .frame(height : UIScreen.main.bounds.height * 0.04)
                    .background(Color.white)
                    .cornerRadius(10)
//                    .frame(
//                        width: UIScreen.main.bounds.width * 0.7,
//                        height : UIScreen.main.bounds.height * 0.05
//                    )
                Button {
                    print("Publish message " + text)
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
//            .frame(width : UIScreen.main.bounds.width * 0.95, height : UIScreen.main.bounds.height * 0.05)
//            .cornerRadius(10)
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
