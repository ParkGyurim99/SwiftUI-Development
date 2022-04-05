//
//  ContentView.swift
//  SendbirdChatPrac
//
//  Created by Park Gyurim on 2022/03/18.
//

import SwiftUI
import SendBirdSDK
import Kingfisher

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    
    var TestChatRoom : some View {
        VStack(spacing : 0) {
            ScrollView {
                ScrollViewReader { proxy in
                    LazyVStack {
                        ForEach(0..<viewModel.messages.count, id : \.self) { index in
                            if viewModel.checkChatDay(index: index) {
                                Text(convertReturnedDateStringToDay(timeInteravlToDate(viewModel.messages[index].createdAt)))
                                    .foregroundColor(.gray)
                                    .font(.system(size : 13, design: .rounded))
                                    .padding()
                            }
                            MessageBox(
                                viewModel.messages[index],
                                mine: viewModel.messages[index].sender?.userId == "1",
                                time : viewModel.checkChatTime(index: index)
                            ).id(viewModel.messages[index].messageId)
                            .padding(.bottom, viewModel.checkChatTime(index: index) ? 5 : -5)
                        }

                    }.onAppear{
                        withAnimation { proxy.scrollTo(viewModel.messages.last?.messageId) }
                    }.onChange(of: viewModel.messages) { newValue in
                        withAnimation { proxy.scrollTo(newValue.last?.messageId) }
                    }
                }
            }
            
            if viewModel.selectedImage != nil {
                Text("Image is selected")
                    .padding(8)
                    .frame(maxWidth : .infinity)
                    .background(Color.black.opacity(0.3))
            }
            
            HStack {
                Button {
                    viewModel.showImagePicker = true
                } label : {
                    Image(systemName: "camera")
                        .foregroundColor(.gray)
                }
                TextField("Text to send", text : $viewModel.text)
                Button {
                    if viewModel.text != "" { viewModel.sendMessage() }
                    if viewModel.selectedImage != nil { viewModel.sendImage() }
                } label : {
                    Image(systemName: "arrow.right")
                }.padding()
            }.padding(.horizontal, 4)
            .background(
                Color.white
                    .edgesIgnoringSafeArea(.bottom)
                    .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: -1)
            )
        }.frame(maxWidth : .infinity)
        .sheet(isPresented: $viewModel.showImagePicker) { ImagePicker(image: $viewModel.selectedImage).edgesIgnoringSafeArea(.bottom) }
        .background(Color.white)
        .navigationBarTitleDisplayMode(.inline)
        .onDisappear {
            viewModel.text = ""
            viewModel.selectedImage = nil
        }
    }
    
    var body: some View {
        VStack {
//            Button {
//                SBDMain.updateCurrentUserInfo(withNickname: "iOS test user", profileUrl: "http://cdn.cnn.com/cnnnext/dam/assets/160621115931-seoul-after.jpg")
//            } label : {
//                Text("Get Current User")
//            }
            
            Button {
                viewModel.fetchMessages()
            } label : {
                Text("Fetch Channel Messages")
            }
            
            NavigationLink {
                ItemInfoView()
            } label: {
                Text("Item Info")
            }
            
            Spacer()
            
            NavigationLink(destination : TestChatRoom)  { Text("Enter Test Chat Room") }
        }.onAppear { viewModel.addDelegate() }
    }
}

struct MessageBox : View {
    var message : SBDBaseMessage
    var mine : Bool = false
    var time : Bool
    
    init(_ message : SBDBaseMessage, time : Bool) {
        self.message = message
        self.time = time
    }
    
    init(_ message : SBDBaseMessage, mine : Bool, time : Bool) {
        self.message = message
        self.mine = mine
        self.time = time
    }
  
    var body : some View {
        VStack(alignment : mine ? .trailing : .leading, spacing : 3) {
            VStack(alignment : .trailing) {
                if message is SBDUserMessage { // -- message w/o image
                    if let message = message.message {
                        Text(message)
                    }
                } else if message is SBDFileMessage { // -- message w/ image
                    if let message = message as? SBDFileMessage {
                        KFImage(URL(string : message.url)!)
                            .placeholder { ProgressView() }
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth : UIScreen.main.bounds.width * 0.6)
                            .cornerRadius(10)
                            
                    }
                } else { // -- message from Admin
                    Text("Admin :" + message.message)
                }
            }.padding(message is SBDFileMessage ? 0 : 10)
            .background(mine ? Color.yellow : Color.gray)
            .cornerRadius(15)
            .shadow(radius: message is SBDFileMessage ? 1 : 0)
            .frame(maxWidth : .infinity, alignment: mine ? .trailing : .leading)
            
            if time {
                Text(convertReturnedDateStringTime(timeInteravlToDate(message.createdAt)))
                    .foregroundColor(.black.opacity(0.7))
                    .font(.system(size : 12, design: .rounded))
                    .frame(maxWidth : .infinity, alignment: mine ? .trailing : .leading)
            }
        }.padding(.horizontal, 10)
    }
}

// NEW
func timeInteravlToDate(_ t : Int64) -> String {
    let dateFormatter = DateFormatter() // 2021-10-03T21:34:20.209447
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.000000"
    dateFormatter.timeZone = NSTimeZone(name: "KST") as TimeZone?

    let dateString : String = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(t / 1000)))
    return dateString
}
    
// TEMP
func convertReturnedDateStringTime(_ timeString : String) -> String {
    var str = timeString // 2021-10-03T21:34:20.209447
    str.removeSubrange(str.startIndex..<str.index(str.startIndex, offsetBy: 11)) // 21:34:20.209447
    str.removeSubrange(str.index(str.startIndex, offsetBy: 5)..<str.endIndex) // 21:34
    
    return str
}

func convertReturnedDateStringToDay(_ timeString : String) -> String {
    var str = timeString // 2021-10-03T21:34:20.209447
    str.removeSubrange(str.index(str.startIndex, offsetBy: 10)..<str.endIndex) // 2021-10-03
    
    return str
}
