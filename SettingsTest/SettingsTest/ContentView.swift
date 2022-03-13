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
    @State var showLogoutAlert : Bool = false
    @State var showAccountInfo : Bool = false
    @State var showChagePasswordView : Bool = false
    @State var showDeleteAccountView : Bool = false
    @State var password : String = ""
    @State var showDeleteConfirm : Bool = false
    
    let mainTheme = Color(red : 248/255, green : 174/255, blue : 0) // yellow1
    
    var alarmSetting : some View {
        VStack {
            Text("Alarm")
                .fontWeight(.bold)
                .padding()
                .frame(width : UIScreen.main.bounds.width, alignment: .leading)
            VStack {
                HStack {
                    Text("Chat Alarm")
                    Spacer()
                    Toggle("", isOn: $tempToggle.animation())
                        .toggleStyle(SwitchToggleStyle(tint: mainTheme))
                }
                HStack {
                    Text("Board Alarm")
                    Spacer()
                    Toggle("", isOn: $tempToggle.animation())
                        .toggleStyle(SwitchToggleStyle(tint: mainTheme))
                }
                HStack {
                    Text("Selling List Alarm")
                    Spacer()
                    Toggle("", isOn: $tempToggle.animation())
                        .toggleStyle(SwitchToggleStyle(tint: mainTheme))
                }
            }.padding(.horizontal)
            .padding(.leading)
            
            
            Color.gray.opacity(0.4)
                .frame(width : UIScreen.main.bounds.width, height : 2)
        }
    }
    var accountSetting : some View {
        VStack {
            Text("Account")
                .fontWeight(.bold)
                .padding()
                .frame(width : UIScreen.main.bounds.width, alignment: .leading)
            VStack {
                NavigationLink(destination : accountInfo, isActive: $showAccountInfo) {
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
                    showAccountInfo.toggle()
                } label : {
                    Image(systemName : "arrow.backward")
                        .foregroundColor(.black)
                }
                Spacer()
                Text("Account Settings")
                    .fontWeight(.semibold)
                Spacer()
                Button {
                    showAccountInfo.toggle()
                } label : {
                    Image(systemName : "arrow.backward")
                        .foregroundColor(.black)
                }.opacity(0)
                .disabled(true)
                
            }.padding()
            .frame(width : UIScreen.main.bounds.width, alignment: .leading)
            .background(Color.white.shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2))
            .padding(.bottom)
            
            NavigationLink(destination : changePassword, isActive: $showChagePasswordView) {
                HStack {
                    Text("Change Password")
                        .foregroundColor(.black)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.black)
                        .font(.system(size : 20))
                }.padding()
            }
            NavigationLink(destination :deleteAccount, isActive: $showDeleteAccountView) {
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
    
    var changePassword : some View {
        VStack(spacing : 0) {
            HStack {
                Button {
                    showChagePasswordView.toggle()
                } label : {
                    Image(systemName : "arrow.backward")
                        .foregroundColor(.black)
                }
            }.padding()
            .frame(width : UIScreen.main.bounds.width, alignment: .leading)
            .background(Color.white.shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2))
            .padding(.bottom)
            Text("Reset Password")
                .font(.system(size : 24, weight : .bold))
                .padding()
                .frame(maxWidth : .infinity, alignment : .leading)
            Spacer()
        }.navigationBarHidden(true)
    }
    var deleteAccount : some View {
        VStack(spacing : 0) {
            HStack {
                Button {
                    showDeleteAccountView.toggle()
                } label : {
                    Image(systemName : "arrow.backward")
                        .foregroundColor(.black)
                }
            }.padding()
            .frame(width : UIScreen.main.bounds.width, alignment: .leading)
            .background(Color.white.shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2))
            .padding(.bottom)
            VStack(spacing : 8) {
                Text("Delete Account")
                    .font(.system(size : 24, weight : .bold))
                    .frame(maxWidth : .infinity, alignment : .leading)
                Text("Please enter your current password\nto verify it is your account. ")
                    .font(.system(size : 16))
                    .frame(maxWidth : .infinity, alignment : .leading)
            }.padding()
            
            SecureField("Password", text : $password)
                .padding(8)
                .padding(.horizontal, 8)
                .background(Color.gray.opacity(0.2)) // systemDefaultGray
                .cornerRadius(8)
                .padding(.horizontal)
            
            Spacer()
            Button {
                showDeleteConfirm = true
            } label : {
                Text("Continue")
                    .font(.system(size : 14, weight: .bold))
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth : .infinity)
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color.yellow))
                    .padding()
            }
        }.navigationBarHidden(true)
        .alert(isPresented: $showDeleteConfirm) {
            Alert(title: Text("Delete Account?"),
                  message: Text("Are you sure you want to delete your account?"),
                  primaryButton: .cancel(Text("Cancel")),
                  secondaryButton: .destructive(Text("Delete")) {
                                        // API CALL
                                    }
            )
        }
    }
    
    var body: some View {
        VStack(spacing : 0) {
            Text("Settings")
                .fontWeight(.medium)
                .padding()
                .frame(width : UIScreen.main.bounds.width)
                .background(Color.white.shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2))
            alarmSetting
            accountSetting
            Spacer()
            Button {
                showLogoutAlert.toggle()
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
        .alert(isPresented: $showLogoutAlert) {
            Alert(title: Text("Log Out"), dismissButton: .default(Text("OK")))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}