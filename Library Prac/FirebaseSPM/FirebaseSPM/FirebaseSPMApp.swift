//
//  FirebaseSPMApp.swift
//  FirebaseSPM
//
//  Created by Park Gyurim on 2021/08/23.
//

import SwiftUI
import Firebase

@main
struct FirebaseSPMApp: App {
    
    // 파이어베이스 초기화 코드
    // 공식 홈페이지(app delegate 사용하는 코드)랑 다름.
    
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init() {
        FirebaseApp.configure() // called once
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

//class AppDelegate : NSObject, UIApplicationDelegate {
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        FirebaseApp.configure()
//        return true
//    }
//}
