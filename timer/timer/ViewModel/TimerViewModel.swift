//
//  TimerViewModel.swift
//  timer
//
//  Created by 박규림 on 2021/01/30.
//

import SwiftUI
import UserNotifications

// Timer Model and Data..

class TimerData : NSObject, UNUserNotificationCenterDelegate, ObservableObject {
    @Published var time : Int = 0
    @Published var selectedTime : Int = 0
    
    // Animation properties..
    @Published var buttonAnimaiton = false
    
    // Timer View data
    @Published var timerViewOffset : CGFloat = UIScreen.main.bounds.height
    @Published var timerHeightChange : CGFloat = 0
    
    
    // for Notifications
    func userNotificationCenter(_ center : UNUserNotificationCenter, willPresent notification : UNNotification, withCompletionHandler completionHandler : @escaping (UNNotificationPresentationOptions) -> Void) {
        
        // telling what to do when receivies in foreground
        completionHandler([.banner, .sound])
    }
    
    // ontab
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("Notification tapped")
        completionHandler()
    }
}
