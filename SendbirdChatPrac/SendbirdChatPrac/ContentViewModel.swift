//
//  ContentViewModel.swift
//  SendbirdChatPrac
//
//  Created by Park Gyurim on 2022/03/18.
//

import SwiftUI
import SendBirdSDK

class ContentViewModel : NSObject, ObservableObject {
    @Published var text : String = ""
    @Published var showImagePicker : Bool = false
    @Published var selectedImage : UIImage? = nil
    @Published var messages : [SBDBaseMessage] = []
    
    let staticChannelUrl = "sendbird_group_channel_68133564_196c3c0ce6f9a2f30fcaf84e2f06b3b2f398e0b7"
    
    func addDelegate() { SBDMain.add(self, identifier: "channel:didReceiveMessage:") }
    
    func groupChannelParams() -> SBDGroupChannelParams {
        let params = SBDGroupChannelParams()
        params.name = "iOS Test Channel"
        params.isDistinct = false
        params.isPublic = true

        return params
    }
    
    func fetchChannelList() {
        let listQuery = SBDGroupChannel.createMyGroupChannelListQuery()
        listQuery?.limit = 15
        
        listQuery?.loadNextPage { groupChannelList, error in
            guard let _ = groupChannelList, error == nil else {
                print(error?.localizedDescription as Any)
                return // Handle error.
            }
            print(groupChannelList as Any)
            for c in groupChannelList! {
                print(c.name, c.channelUrl)
            }
            
            //self.channelList.append(contentsOf: groupChannels)
        }
    }
    
//    func fetchPreviousMessages() {
//        
//    }
}

// Sendbird Channel Delegate
extension ContentViewModel : SBDChannelDelegate {
    func channel(_ sender: SBDBaseChannel, didReceive message: SBDBaseMessage) {
        // You can customize how to display the different types of messages with the result object in the "message" parameter.
        if message.channelUrl == staticChannelUrl {
            print("Sender :", sender.name)
            if message is SBDUserMessage {
                print("UserMessage", message.message)
                print("From", message.channelUrl)
                messages.append(message)
            }
            else if message is SBDFileMessage {
                print("FileMessage", message.message)
                print("From", message.channelUrl)
                let msg : SBDFileMessage = message as! SBDFileMessage
                print(msg.url)
                messages.append(message)
            }
            else if message is SBDAdminMessage {
                print("AdminMessage", message.message)
                print("From", message.channelUrl)
                messages.append(message)
            }
        } else {
            print("Receive message from another channel.")
        }
    }
}
