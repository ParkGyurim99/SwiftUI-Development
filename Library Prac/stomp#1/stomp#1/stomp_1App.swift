//
//  stomp_1App.swift
//  stomp#1
//
//  Created by Park Gyurim on 2021/12/27.
//

import SwiftUI
import URLImageStore
import URLImage

@main
struct stomp_1App: App {
    let urlImageService = URLImageService(fileStore: nil, inMemoryStore: URLImageInMemoryStore())

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.urlImageService, urlImageService)
                .preferredColorScheme(.light)
        }
    }
}
