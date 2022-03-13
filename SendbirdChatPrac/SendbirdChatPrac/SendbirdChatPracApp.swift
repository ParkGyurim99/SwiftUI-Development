//
//  SendbirdChatPracApp.swift
//  SendbirdChatPrac
//
//  Created by Park Gyurim on 2022/03/11.
//

import SwiftUI
import SendBirdSDK

@main
struct SendbirdChatPracApp: App {
    let params = SBDOpenChannelParams()
    var url = ""
    
    
    init() {
        SBDMain.initWithApplicationId("1DE2EA6D-96CB-4497-8191-19FA7A8B7811")
        SBDMain.connect(withUserId: "A") { user, error in
            if let _ = error {
                print(error?.localizedDescription)
            }
            
            print(user?.nickname)
            print(user?.userId)
        }
        SBDOpenChannel.createChannel(with: params) { channel, error in
            print(channel?.name)
            print(channel?.participantCount)
            SBDOpenChannel.getWithUrl(channel!.channelUrl) { ch, err in
                print(ch?.name)
            }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
