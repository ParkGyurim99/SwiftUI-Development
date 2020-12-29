//
//  app006App.swift
//  app006
//
//  Created by 박규림 on 2020/12/22.
//

import SwiftUI

@main
struct app006App: App {
    var body: some Scene {
        WindowGroup {
            //ContentView()
            myCustomTabView(tIndex: .profile)
            //myTabView()
        }
    }
}
