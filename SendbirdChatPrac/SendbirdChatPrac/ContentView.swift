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
                SBDGroupChannel.createChannel(with: viewModel.groupChannelParams()) { groupChannel, error in
                    guard let channelUrl = groupChannel?.channelUrl, error == nil else {
                        return // Handle error.
                    }
                    
                    SBDGroupChannel.getWithUrl(channelUrl) { groupChannel, error in
                        guard let groupChannel = groupChannel, error == nil else {
                            return // Handle error.
                        }
                        
                        groupChannel.sendUserMessage("Test Message") { userMessage, error in
                            guard let _ = userMessage, error == nil else {
                                print(error?.localizedDescription as Any)
                                return // Handle error.
                            }

                            // The message is successfully sent to the channel.
                            // The current user can receive messages from other users through the channel:didReceiveMessage: method of an event delegate.
                            print("Enter Channel and Send Message Done")
                        }
                    }
                }
                
                
                // Send Text Message to Existing Channel
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
                Text("Create and Enter the Chat channel")
                    .padding()
            }
            
            Spacer()
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
        }.sheet(isPresented: $viewModel.showImagePicker) {
            ImagePicker(image: $viewModel.selectedImage).edgesIgnoringSafeArea(.bottom)
        }
    }
}
