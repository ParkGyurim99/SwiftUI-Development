//
//  ContentView.swift
//  SendbirdChatPrac
//
//  Created by Park Gyurim on 2022/03/18.
//

import SwiftUI
import SendBirdSDK

struct ContentView: View {
    @State var text : String = ""
    let channelUrl = "sendbird_open_channel_5033_c32caf026cb3ce977317fc82a05790baf3e00a8f"
    
    func createChannel() -> SBDOpenChannelParams {
        let params = SBDOpenChannelParams()
        params.name = "iOS Test Channel"
        
        return params
    }
    
    var body: some View {
        Button {
            // iOS Test Channel
            SBDOpenChannel.getWithUrl(channelUrl) { openChannel, error in
                    guard let openChannel = openChannel, error == nil else {
                            return // Handle error.
                    }
                    // Call the instance method of the result object in the "openChannel" parameter of the callback method.

                openChannel.enter(completionHandler: { error in
                    guard error == nil else { return }
                    
                    // The current user successfully enters the open channel,
                    // and can chat with other users in the channel by using APIs.
                    print("Successfully Enter the channel : " + openChannel.name)
                    openChannel.sendUserMessage("Test Message") { userMessage, error in
                        guard let userMessage = userMessage, error == nil else {
                            print(error?.localizedDescription as Any)
                            return // Handle error.
                        }

                        // The message is successfully sent to the channel.
                        // The current user can receive messages from other users through the channel:didReceiveMessage: method of an event delegate.
                        print("Enter Channel and Send Message Done")
                    }
                })
            }
                                      
//            SBDOpenChannel.createChannel(with: createChannel()) { channel, error in
//                guard let channel = channel, error == nil else {
//                    print(error?.localizedDescription as Any)
//                    return // Handle error.
//                }
//
//                // An open channel is successfully created.
//                // Through the "openChannel" parameter of the callback method,
//                // you can get the open channel's data from the Sendbird server.
//                print("Create Channel Done")
//                print(channel.channelUrl + "," + channel.name)
//
//
//                SBDOpenChannel.getWithUrl(channel.channelUrl) { openChannel, error in
//                    guard let openChannel = openChannel, error == nil else {
//                        print(error?.localizedDescription as Any)
//                        return // Handle error.
//                    }
//                    // Call the instance method of the result object in the "openChannel" parameter of the callback method.
//
//                    openChannel.enter(completionHandler: { error in
//                        guard error == nil else { return }
//
//                        // The current user successfully enters the open channel,
//                        // and can chat with other users in the channel by using APIs.
//                        print("Successfully Enter the channel : " + channel.name)
//                        openChannel.sendUserMessage("Test Message") { userMessage, error in
//                            guard let userMessage = userMessage, error == nil else {
//                                print(error?.localizedDescription as Any)
//                                return // Handle error.
//                            }
//
//                            // The message is successfully sent to the channel.
//                            // The current user can receive messages from other users through the channel:didReceiveMessage: method of an event delegate.
//                            print("Enter Channel and Send Message Done")
//                        }
//                    })
//                }
//            }
        } label : {
            Text("Create and Enter the Chat channel")
                .padding()
        }
        
        Spacer()
        HStack {
            TextField("Text to send", text : $text)
            Button {
                SBDOpenChannel.getWithUrl(channelUrl) { openChannel, error in
                    guard let openChannel = openChannel, error == nil else {
                            return // Handle error.
                    }
                    // Call the instance method of the result object in the "openChannel" parameter of the callback method.
                    openChannel.enter(completionHandler: { error in
                        guard error == nil else { return }
                        
                        // The current user successfully enters the open channel,
                        // and can chat with other users in the channel by using APIs.
                        print("Successfully Enter the channel : " + openChannel.name)
                        openChannel.sendUserMessage(text) { userMessage, error in
                            guard let userMessage = userMessage, error == nil else {
                                print(error?.localizedDescription as Any)
                                return // Handle error.
                            }
                            print("Created At", userMessage.createdAt)
                            print("Message ID", userMessage.messageId)
                            print("Sender", userMessage.sender)
                            // The message is successfully sent to the channel.
                            // The current user can receive messages from other users through the channel:didReceiveMessage: method of an event delegate.
                            print("Enter Channel and Send Message Done")
                            text = ""
                        }
                    })
                }
            } label : {
                Image(systemName: "arrow.right")
            }.padding()
        }
    }
}
