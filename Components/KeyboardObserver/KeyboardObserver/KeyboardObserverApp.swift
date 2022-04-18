//
//  KeyboardObserverApp.swift
//  KeyboardObserver
//
//  Created by Park Gyurim on 2022/04/17.
//

import SwiftUI

@main
struct KeyboardObserverApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HStack {
                    NavigationLink { SignInView() } label : {
                        Text("SignIn")
                    }
                    NavigationLink { SignUpView() } label : {
                        Text("SignUp")
                    }
                }.navigationTitle(Text(""))
            }.navigationViewStyle(.stack)
            .accentColor(.black)
        }
    }
}
