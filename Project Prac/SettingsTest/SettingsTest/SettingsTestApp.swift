//
//  SettingsTestApp.swift
//  SettingsTest
//
//  Created by Park Gyurim on 2022/03/08.
//

import SwiftUI

@main
struct SettingsTestApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView { ContentView().preferredColorScheme(.light) }.navigationViewStyle(StackNavigationViewStyle())
        }
    }
}
