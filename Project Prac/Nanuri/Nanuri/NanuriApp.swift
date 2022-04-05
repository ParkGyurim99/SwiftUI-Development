//
//  NanuriApp.swift
//  Nanuri
//
//  Created by Park Gyurim on 2022/01/28.
//

import SwiftUI
import URLImage
import URLImageStore
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct NanuriApp: App {
    let urlImageService = URLImageService(fileStore: nil, inMemoryStore: URLImageInMemoryStore())
    
    init() { KakaoSDK.initSDK(appKey: "c95be0b24be89d4167b238b296e8396d") }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL { url in
                    if (AuthApi.isKakaoTalkLoginUrl(url)) {
                        _ = AuthController.handleOpenUrl(url: url)
                    }
                }
                .environment(\.urlImageService, urlImageService)
                .preferredColorScheme(.light)
        }
    }
}
