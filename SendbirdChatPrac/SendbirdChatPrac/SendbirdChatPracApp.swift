//
//  SendbirdChatPracApp.swift
//  SendbirdChatPrac
//
//  Created by Park Gyurim on 2022/03/18.
//

import SwiftUI
import SendBirdSDK

@main
struct SendbirdChatPracApp: App {
    init() {
        SBDMain.initWithApplicationId("1DE2EA6D-96CB-4497-8191-19FA7A8B7811", useCaching: false) {
            print("migrationStartHandler")
        } completionHandler: { error in
            print(error?.localizedDescription as Any)
        }
        
        SBDMain.connect(withUserId: "1") { user, error in
            guard let user = user, error == nil else {
                print("\(user!) got error : " + error!.localizedDescription)
                return // Handle error.
            }

            // The user is connected to the Sendbird server.
            print("\(user) is connected to server")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
