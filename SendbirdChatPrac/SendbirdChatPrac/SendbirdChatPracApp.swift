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
        SBDMain.initWithApplicationId("1DE2EA6D-96CB-4497-8191-19FA7A8B7811")
        SBDMain.connect(withUserId: "63") { user, error in
            guard let user = user, error == nil else { return } // Handle error.
            print("User : \(user) is connected to Sendbird server")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView { ContentView().preferredColorScheme(.light) }
        }
    }
}
