//
//  ItemInfoApp.swift
//  ItemInfo
//
//  Created by Park Gyurim on 2022/06/08.
//

import SwiftUI

@main
struct ItemInfoApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ItemInfoView()
                    .preferredColorScheme(.light)
            }
        }
    }
}
