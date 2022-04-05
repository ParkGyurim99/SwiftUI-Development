//
//  Home.swift
//  timer
//
//  Created by 박규림 on 2021/01/30.
//

import SwiftUI
// sending notification
import UserNotifications

struct Home: View {
    //@StateObject var data = TimerData()
    @EnvironmentObject var data : TimerData
    
    var body: some View {
        ZStack {
            VStack {
                Button {
                    // resetting
                    withAnimation {
                        data.time = 0
                        data.selectedTime = 0
                        data.timerHeightChange = 0
                        data.timerViewOffset = UIScreen.main.bounds.height
                        data.buttonAnimaiton = false
                    }
                } label : {
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                        .font(.system(size : 30))
                }.padding(.top, 50)
                .offset(x : 160)
                
                Spacer()
                
                ScrollView(.horizontal, showsIndicators: false, content: {
                    //Timer Button
                    HStack (spacing : 20) {
                        ForEach(1...6, id : \.self) {index in
                            let time = index * 5
                            Text("\(time)")
                                .font(.system(size : 45, weight : .heavy))
                                .frame(width : 100, height: 100)
                                .background(data.time == time ? Color.pink : Color.blue)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                                .onTapGesture {
                                    withAnimation {
                                        data.time = time
                                        data.selectedTime = time
                                    }
                                }
                        }
                    }.padding()
                })
                .offset(y : 40)
                .opacity(data.buttonAnimaiton ? 0 : 1)
                
                Spacer()
                
                //Start Button
                Button {
                    withAnimation(Animation.easeInOut(duration : 0.65)) {
                        data.buttonAnimaiton.toggle()
                    }
                    // Delay animation
                    // After button goes down view is moving up
                    withAnimation(Animation.easeIn.delay(0.6)) {
                        data.timerViewOffset = 0
                    }
                    
                    //notification
                    performNotification()
                } label : {
                    Circle()
                        .fill(Color.pink)
                        .frame(width : 80, height : 80)
                        .overlay(
                            Image(systemName : "play")
                                .foregroundColor(.white)
                                .font(.system(size : 40))
                                .opacity(data.time == 0 ? 0 : 1)
                        )
                }
                .padding(.bottom, 35)
                .disabled(data.time == 0)
                .opacity(data.time == 0 ? 0.6 : 1)
                // moving down smoothly..
                .offset(y : data.buttonAnimaiton ? 300 : 0)
            } // VStack
            
            
            Color.pink
                .overlay(
                    Text("\(data.selectedTime)")
                        .font(.system(size : 55, weight : .heavy))
                        .foregroundColor(.white)
                )
                // decreasing height for each count
                .frame(height : UIScreen.main.bounds.height - data.timerHeightChange)
                .frame(maxWidth : .infinity, maxHeight : .infinity, alignment: .bottom)
                .ignoresSafeArea(.all)
                .offset(y : data.timerViewOffset)
        } // ZStack
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.init(#colorLiteral(red: 0.3245181441, green: 0.2748230696, blue: 0.5401465297, alpha: 1)))
        .ignoresSafeArea(.all)
        // Timer Functionality
        .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect(), perform: { _ in
            
            // Condition
            if data.time != 0 && data.selectedTime != 0 && data.buttonAnimaiton {
                // count down
                data.selectedTime -= 1
                
                // updating height
                let ProgressHeight = UIScreen.main.bounds.height / CGFloat(data.time)
                let diff = data.time - data.selectedTime
                
                withAnimation {
                    data.timerHeightChange = CGFloat(diff) * ProgressHeight
                }
                
                //resetting
                if data.selectedTime == 0 {
                    withAnimation {
                        data.time = 0
                        data.selectedTime = 0
                        data.timerHeightChange = 0
                        data.timerViewOffset = UIScreen.main.bounds.height
                        data.buttonAnimaiton = false
                    }
                }
            }
        })
        .onAppear(perform: {
            //Permissions..
            UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert]) { (_, _) in
                
                
            }
            
            // Setting Delegate For In - App Notifications..
            UNUserNotificationCenter.current().delegate = data
        })
    } // body
    
    
    func performNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Notification from GYURIM"
        content.body = "Timer has been Finished !!"
        
        // triggring at selected timer .
        // for eg 5 seconds means after 5 seconds
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(data.time), repeats: false)
        
        let request = UNNotificationRequest(identifier: "TIMER", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (err) in
            if err != nil {
                print(err!.localizedDescription)
            }
        }
    }
}
