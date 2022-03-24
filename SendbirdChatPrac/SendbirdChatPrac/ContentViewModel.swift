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
    
    let staticChannelUrl = "sendbird_group_channel_68133564_f31db89ca6f0333272cee22ada8e459b1986d3bc"
    
    func addDelegate() { SBDMain.add(self, identifier: "channel:didReceiveMessage:") }
    
    // Channel 생성시 필요
    func groupChannelParams() -> SBDGroupChannelParams {
        let params = SBDGroupChannelParams()
        params.name = "iOS Test Channel"
        params.isDistinct = false
        params.isPublic = true

        return params
    }
    
    
    func fetchMessages() {
        SBDGroupChannel.getWithUrl(staticChannelUrl) { groupChannel, error in
            guard let groupChannel = groupChannel, error == nil else { return }
            
            let listQuery = groupChannel.createPreviousMessageListQuery()
            // Retrieve a list of messages along with their metaarrays.
            listQuery?.includeMetaArray = false
            // Retrieve a list of messages along with their reactions.
            listQuery?.includeReactions = false

            listQuery?.loadPreviousMessages(withLimit: 100, reverse: false) { [weak self] (messages, error) in
                guard error == nil else { return }
                self?.messages = messages ?? []
                
                print("Fecthing Message Done")
            }
        }
    }
    
    func sendMessage() {
        SBDGroupChannel.getWithUrl(staticChannelUrl) { groupChannel, error in
            guard let groupChannel = groupChannel, error == nil else { return }
            
            groupChannel.sendUserMessage(self.text) { [weak self] (userMessage, error) in
                guard let message = userMessage, error == nil else { return }
                
                self?.messages.append(message)
                self?.text = ""
                
                print("Send Message Done")
            }
        }
    }
    func sendImage() {
        SBDGroupChannel.getWithUrl(staticChannelUrl) { groupChannel, error in
            guard let image = self.selectedImage, let groupChannel = groupChannel, error == nil else { return }
            
            groupChannel.sendFileMessage(with: SBDFileMessageParams(file: image.jpegData(compressionQuality: 0.8)!)!) { [weak self] (fileMessage, error) in
                guard let message = fileMessage, error == nil else { return }
                
                self?.messages.append(message)
                self?.selectedImage = nil
                self?.text = ""
                
                print("Send Image Message Done")
            }
        }
    }
    
    // Not gonna use.
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
    
    func checkChatDay(index : Int) -> Bool {
        if index == 0 { return true }
        else {
            if convertReturnedDateStringToDay(timeInteravlToDate(messages[index].createdAt)) == convertReturnedDateStringToDay(timeInteravlToDate(messages[index - 1].createdAt)) {
                return false
            } else { return true }
        }
    }

    func checkChatTime(index : Int) -> Bool {
        if index == messages.count - 1 { return true }
        else {
            if convertReturnedDateStringTime(timeInteravlToDate(messages[index].createdAt)) == convertReturnedDateStringTime(timeInteravlToDate(messages[index + 1].createdAt)) {
                return false
            } else { return true }
        }
    }

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
