//
//  IncrementApp.swift
//  Increment
//
//  Created by Park Gyurim on 2021/08/24.
//

import SwiftUI
import Firebase

@main
struct IncrementApp: App {
    @StateObject private var appState = AppState()
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            if appState.isLoggedIn {
                TabContainerView()
                    .preferredColorScheme(isDarkMode ? .dark : .light)
            } else {
                LandingView()
            }
        }
    }
}

class AppState : ObservableObject {
    @Published private(set) var isLoggedIn = false
    private let userService : UserServiceProtocol
    
    init(userService : UserServiceProtocol = UserService()) {
        self.userService = userService
        try? Auth.auth().signOut( )
        
        // observing publisher here
        userService
            .observeAuthChanges()
            .map { $0 != nil } // mapping true or false Boolean value
            .assign(to: &$isLoggedIn) // $isLoggedIn 는 Published<Bool>Publisher type
    }
}
