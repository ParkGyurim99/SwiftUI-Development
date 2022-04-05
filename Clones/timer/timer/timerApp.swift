//
//  timerApp.swift
//  timer
//
//  Created by 박규림 on 2021/01/30.
//

import SwiftUI

@main
struct timerApp: App {
    @StateObject var data = TimerData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(data)
        }
    }
}
