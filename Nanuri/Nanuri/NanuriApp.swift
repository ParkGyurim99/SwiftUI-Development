//
//  NanuriApp.swift
//  Nanuri
//
//  Created by Park Gyurim on 2022/01/28.
//

import SwiftUI
import URLImage
import URLImageStore

@main
struct NanuriApp: App {
    let urlImageService = URLImageService(fileStore: nil, inMemoryStore: URLImageInMemoryStore())
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.urlImageService, urlImageService)
                .preferredColorScheme(.light)
        }
    }
}
