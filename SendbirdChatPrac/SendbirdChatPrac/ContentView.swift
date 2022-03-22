//
//  ContentView.swift
//  SendbirdChatPrac
//
//  Created by Park Gyurim on 2022/03/18.
//

import SwiftUI
import SendBirdSDK

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    
    let staticChannelUrl = "sendbird_group_channel_68133564_196c3c0ce6f9a2f30fcaf84e2f06b3b2f398e0b7"
    
    var body: some View {
        VStack {
            Button {
                viewModel.fetchChannelList()
            } label : {
                Text("Fetch Channel List")
                    .padding()
            }
            
            Button {
                // Create Channel
//                SBDGroupChannel.createChannel(with: viewModel.groupChannelParams()) { groupChannel, error in
//                    guard let channelUrl = groupChannel?.channelUrl, error == nil else {
//                        return // Handle error.
//                    }
//
//                    var userIds: [String] = []
//                    userIds.append("2")
//
//                    groupChannel.inviteUserIds(userIds, completionHandler: { (error) in
//                        guard error == nil else {
//                            return
//                        }
//
//                    })
//
//                    SBDGroupChannel.getWithUrl(channelUrl) { groupChannel, error in
//                        guard let groupChannel = groupChannel, error == nil else {
//                            return // Handle error.
//                        }
//
//                        groupChannel.sendUserMessage("Test Message") { userMessage, error in
//                            guard let _ = userMessage, error == nil else {
//                                print(error?.localizedDescription as Any)
//                                return // Handle error.
//                            }
//
//                            // The message is successfully sent to the channel.
//                            // The current user can receive messages from other users through the channel:didReceiveMessage: method of an event delegate.
//                            print("Enter Channel and Send Message Done")
//                        }
//                    }
//                }
                
                // Send Text Message to Existing Channel
                SBDGroupChannel.getWithUrl(staticChannelUrl) { groupChannel, error in
                    guard let groupChannel = groupChannel, error == nil else {
                        return // Handle error.
                    }
                    
                    // There should be only one single instance per channel.
                    let listQuery = groupChannel.createPreviousMessageListQuery()
                    listQuery?.includeMetaArray = true  // Retrieve a list of messages along with their metaarrays.
                    listQuery?.includeReactions = true  // Retrieve a list of messages along with their reactions.

                    // Retrieving previous messages.
                    listQuery?.loadPreviousMessages(withLimit: 100, reverse: true) { (messages, error) in
                        guard error == nil else { return }
                        
                        viewModel.messages = messages ?? []
                        
                        let dateFormatter = DateFormatter()
                            // 2021-10-03T21:34:20.209447
                        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.000000"
                        dateFormatter.timeZone = NSTimeZone(name: "KST") as TimeZone?

                        //let date:Date = dateFormatter.date(from: dateString)!
                        
                        for message in messages! {
                            let dateString : String = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(message.createdAt / 1000)))
                            
                            print(message.sender?.userId , " : ",
                                  message.message,
                                  dateString
                                  //Date(timeIntervalSince1970: TimeInterval(message.createdAt / 1000 + 32400))
                            )
                        }
                    }
                    
                    groupChannel.sendUserMessage("Placeholder") { userMessage, error in
                    //groupChannel.sendUserMessage(viewModel.text) { userMessage, error in
                        guard let _ = userMessage, error == nil else {
                            print(error?.localizedDescription as Any)
                            return // Handle error.
                        }

                        // The message is successfully sent to the channel.
                        // The current user can receive messages from other users through the channel:didReceiveMessage: method of an event delegate.
                        print("Enter Channel and Send Message Done")
                    }
                }
            } label : {
                Text("Create and Enter the Chat channel")
                    .padding()
            }
            
            Spacer()
            /*
            Button {
                viewModel.showImagePicker = true
            } label : {
                Text("Select Image")
            }
            if viewModel.selectedImage != nil {
                Text("Image is selected")
                    .fontWeight(.semibold)
                Button {
                    SBDGroupChannel.getWithUrl(staticChannelUrl) { groupChannel, error in
                        guard let groupChannel = groupChannel, error == nil else {
                            return // Handle error.
                        }
                        
                        groupChannel.sendFileMessage(with: SBDFileMessageParams(file: viewModel.selectedImage!.jpegData(compressionQuality: 0.8)!)!) { fileMessage, error in
                            guard let fileMessage = fileMessage, error == nil else {
                                print(error?.localizedDescription as Any)
                                return // Handle error.
                            }
                            
                            print(fileMessage)
                            print("Send Message with File Done")
                        }
                    }
                } label : {
                    Text("Send Image")
                }
            }
            Spacer()
            */
            NavigationLink {
                VStack {
                    ScrollView {
                        ForEach(viewModel.messages, id : \.self) { message in
                            //Text("\(message.sender?.userId) :" + message.message)
                            MessageBox(message, mine: message.sender?.userId == "1")
                                .rotationEffect(Angle(degrees: 180))
                        }
                    }.rotationEffect(Angle(degrees: 180))
                }.frame(maxWidth : .infinity)
                .edgesIgnoringSafeArea(.bottom)
                .background(Color.white)
                .navigationBarTitleDisplayMode(.inline)
            } label : {
                Text("Test Chat Room")
            }
            
            HStack {
                TextField("Text to send", text : $viewModel.text)
                Button {
                    SBDGroupChannel.getWithUrl(staticChannelUrl) { groupChannel, error in
                        guard let groupChannel = groupChannel, error == nil else {
                            return // Handle error.
                        }
                        
                        groupChannel.sendUserMessage(viewModel.text) { userMessage, error in
                            guard let _ = userMessage, error == nil else {
                                print(error?.localizedDescription as Any)
                                return // Handle error.
                            }

                            // The message is successfully sent to the channel.
                            // The current user can receive messages from other users through the channel:didReceiveMessage: method of an event delegate.
                            print("Enter Channel and Send Message Done")
                        }
                    }
                } label : {
                    Image(systemName: "arrow.right")
                }.padding()
            }
        }.onAppear { viewModel.addDelegate() }
        .sheet(isPresented: $viewModel.showImagePicker) {
            ImagePicker(image: $viewModel.selectedImage).edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct MessageBox : View {
    var message : SBDBaseMessage
    var mine : Bool = false
    
    init(_ message : SBDBaseMessage, mine : Bool) {
        self.message = message
        self.mine = mine
    }
  
    var body : some View {
        VStack(alignment : mine ? .trailing : .leading, spacing : 3) {
            VStack {
                VStack(alignment : .trailing) {
                    // -- message w/o image
                    if let message = message.message {
                        Text(message)
                    }
                    // -- message w/ image
//                    if message.image != "null" {
//                        KFImage(URL(string : message.image ?? imagePlaceHolder)!)
//                            .resizable()
//                            .aspectRatio(contentMode: .fill)
//                            .frame(maxWidth : UIScreen.main.bounds.width * 0.6)
//                            .cornerRadius(10)
//                    }
                }
                .padding(10)
                .background(mine ? Color.yellow : Color.gray)
                .cornerRadius(15)
                .frame(maxWidth : .infinity, alignment: mine ? .trailing : .leading)
                
                Text(convertReturnedDateStringTime(timeInteravlToDate(message.createdAt)))
                    .foregroundColor(.black.opacity(0.7))
                    .font(.system(size : 12, design: .rounded))
                    .frame(maxWidth : .infinity, alignment: mine ? .trailing : .leading)
            }
        }.padding(.horizontal, 10)
    }
}


func timeInteravlToDate(_ t : Int64) -> String {
    let dateFormatter = DateFormatter() // 2021-10-03T21:34:20.209447
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.000000"
    dateFormatter.timeZone = NSTimeZone(name: "KST") as TimeZone?

    let dateString : String = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(t / 1000)))
    return dateString
}
    
func convertReturnedDateStringTime(_ timeString : String) -> String {
    var str = timeString // 2021-10-03T21:34:20.209447
    str.removeSubrange(str.startIndex..<str.index(str.startIndex, offsetBy: 11)) // 21:34:20.209447
    str.removeSubrange(str.index(str.startIndex, offsetBy: 5)..<str.endIndex) // 21:34
    
    return str
}
