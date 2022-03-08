//
//  ContentView.swift
//  SettingsTest
//
//  Created by Park Gyurim on 2022/03/08.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var tempToggle : Bool = false
    
    var alarmSetting : some View {
        VStack {
            Text("Alarm")
                .fontWeight(.medium)
                .padding()
                .frame(width : UIScreen.main.bounds.width, alignment: .leading)
            VStack {
                HStack {
                    Text("Chat Alarm")
                    Spacer()
                    Toggle("", isOn: $tempToggle)
                }
                HStack {
                    Text("Board Alarm")
                    Spacer()
                    Toggle("", isOn: $tempToggle)
                }
                HStack {
                    Text("Selling List Alarm")
                    Spacer()
                    Toggle("", isOn: $tempToggle)
                }
            }.padding(.horizontal)
            .padding(.leading)
            
            
            Color.gray.opacity(0.4)
                .frame(width : UIScreen.main.bounds.width, height : 2)
                .padding(.vertical)
        }
    }
    var accountSetting : some View {
        VStack {
            Text("Account")
                .fontWeight(.medium)
                .padding()
                .frame(width : UIScreen.main.bounds.width, alignment: .leading)
            VStack {
                NavigationLink(destination : accountInfo) {
                    HStack {
                        Image(systemName: "person.circle")
                            .font(.system(size : 20))
                        Text("Account Info")
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.system(size : 20))
                    }.foregroundColor(.black)
                }.padding(.bottom, 10)
                
                HStack {
                    Image(systemName: "circle.slash")
                        .font(.system(size : 20))
                    Text("Blocked Users")
                    Spacer()
                    Button {
                        
                    } label : {
                        Image(systemName: "chevron.right")
                            .font(.system(size : 20))
                            .foregroundColor(.black)
                    }
                }.padding(.bottom, 10)
            }.padding(.horizontal)
            .padding(.leading)
        }
    }
    
    var accountInfo : some View {
        VStack(spacing : 0) {
            HStack {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label : {
                    Image(systemName : "arrow.backward")
                        .foregroundColor(.black)
                }
                Text("Account Settings")
                    .fontWeight(.medium)
            }.padding()
            .frame(width : UIScreen.main.bounds.width, alignment: .leading)
            .background(Color.white.shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2))
            
            NavigationLink(destination : Text("change password view")) {
                HStack {
                    Text("Change Password")
                        .foregroundColor(.black)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.black)
                        .font(.system(size : 20))
                }.padding()
            }
            NavigationLink(destination : Text("delete account view")) {
                HStack {
                    Text("Delete Account")
                        .foregroundColor(.red)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.black)
                        .font(.system(size : 20))
                }.padding()
            }
            Spacer()
        }.navigationBarHidden(true)
    }
    
    var body: some View {
        VStack(spacing : 0) {
            Text("Settings")
                .fontWeight(.medium)
                .padding()
                .frame(width : UIScreen.main.bounds.width, alignment: .leading)
                .background(Color.white.shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2))
            alarmSetting
            accountSetting
            Spacer()
            Button {

            } label : {
                Text("Log Out")
                    .fontWeight(.semibold)
                    .foregroundColor(.red)
                    .padding()
            }

            // Tab bar placeholder
            Color.white
                .frame(height : 80)
                .background(Color.white.shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: -2))
        }.navigationBarHidden(true)
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
