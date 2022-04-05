//
//  ContentView.swift
//  SettingsTest
//
//  Created by Park Gyurim on 2022/03/08.
//

import SwiftUI

struct ContentView: View {
    // TEMP
    @State var tempToggle : Bool = false
    @State var showLogoutAlert : Bool = false
    @State var showAccountInfo : Bool = false
    @State var showChagePasswordView : Bool = false
    @State var showDeleteAccountView : Bool = false
    
    @State var currentPassword : String = ""
    
    @State var newPassword : String = ""
    @State var newPasswordConfirm : String = ""
    @State var resetPasswordStep : Int = 1
    @State var resetBtnClicked : Bool = false
    @State var resetPasswordSuccess : Bool = false
    @State var resetPasswordFail : Bool = false
    
    @State var deleteAccountStep : Int = 1
    @State var deleteAccountFeedback : String = ""
    @State var deleteAccountBtnClicked : Bool = false
    @State var deleteAccountSuccess : Bool = false
    @State var deleteAccountFailAlertType : Int = 0
    @State var deleteAccountFail : Bool = false
    @State var showDeleteAccountAlert : Bool = false
    @State var showDeleteAccountConfirm : Bool = false
    
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
                HStack {
                    Image(systemName: "chevron.left.forwardslash.chevron.right")
                        .font(.system(size : 20))
                    Text("Open Source Code")
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
            
            NavigationLink(destination : resetPassword, isActive: $showChagePasswordView) {
                HStack {
                    Text("Change Password")
                        .fontWeight(.medium)
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
                        .fontWeight(.medium)
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
    var resetPassword : some View {
        ZStack {
        VStack(spacing : 0) {
            HStack {
                Button {
                    showChagePasswordView.toggle()
                } label : {
                    Image(systemName : "arrow.backward")
                        .foregroundColor(.black)
                }
                Text("Back")
                    .opacity(0)
            }.padding()
            .frame(width : UIScreen.main.bounds.width, alignment: .leading)
            .background(Color.white.shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2))
            .padding(.bottom)
            
            if resetPasswordStep == 1 {
                Text("Reset Password")
                    .font(.system(size : 24, weight : .bold))
                    .frame(maxWidth : .infinity, alignment : .leading)
                    .padding(.horizontal)
                    .padding(.top)
                VStack(spacing : 8) {
                    Text("Please enter your current password\nto verify it is your account. ")
                        .font(.system(size : 16))
                        .frame(maxWidth : .infinity, alignment : .leading)
                }.padding()
                
                SecureField("Password", text : $currentPassword)
                    .padding(8)
                    .padding(.horizontal, 8)
                    .background(Color.gray.opacity(0.2)) // systemDefaultGray
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                Spacer()
                Button {
                    resetPasswordStep = 2
                } label : {
                    Text("Continue")
                        .font(.system(size : 14, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth : .infinity)
                        .background(RoundedRectangle(cornerRadius: 8).fill(currentPassword.isEmpty ? Color.gray.opacity(0.5) : Color.yellow))
                        .padding()
                }.disabled(currentPassword.isEmpty)
            } else {
                Text("New Password")
                    .font(.system(size : 24, weight : .bold))
                    .frame(maxWidth : .infinity, alignment : .leading)
                    .padding(.horizontal)
                    .padding(.top)
                VStack(spacing : 8) {
                    Text("Please enter your new password.")
                        .font(.system(size : 16))
                        .frame(maxWidth : .infinity, alignment : .leading)
                    SecureField("Password", text : $newPassword)
                        .padding(8)
                        .padding(.horizontal, 8)
                        .background(Color.gray.opacity(0.2)) // systemDefaultGray
                        .cornerRadius(8)
                    if !newPassword.isEmpty {
                        Text("Password must contain: ")
                            .font(.system(size: 14))
                            .foregroundColor(newPassword.count > 7 && newPassword.containsCapitals() && newPassword.containsNumbers() ? .green : .red)
                            .frame(maxWidth : .infinity, alignment: .leading)
                            .padding(.horizontal, 6)
                        VStack {
                            VStack(alignment : .leading) {
                                Text("✓ At least 8 characters")
                                    .foregroundColor(newPassword.count > 7 ? .green : .red)
                                Text("✓ 1 Uppercase Letter (A-Z)")
                                    .foregroundColor(newPassword.containsCapitals() ? .green : .red)
                                Text("✓ 1 Number (0-9)")
                                    .foregroundColor(newPassword.containsNumbers() ? .green : .red)
                            }.padding(.horizontal, 18)
                        }.font(.system(size: 14))
                        .frame(maxWidth : .infinity, alignment: .leading)
                    }
                    Text("Confirm new password.")
                        .font(.system(size : 16))
                        .frame(maxWidth : .infinity, alignment : .leading)
                    SecureField("Password", text : $newPasswordConfirm)
                        .padding(8)
                        .padding(.horizontal, 8)
                        .background(Color.gray.opacity(0.2)) // systemDefaultGray
                        .cornerRadius(8)
                    if !newPasswordConfirm.isEmpty {
                        Text("Password does not match.")
                            .font(.system(size: 14))
                            .foregroundColor(.red)
                            .frame(maxWidth : .infinity, alignment: .leading)
                            .padding(.horizontal, 6)
                            .opacity(newPassword == newPasswordConfirm ? 0 : 1)
                    }
                }.padding()
                
                Spacer()
                Button {
                    // API Call
                    resetBtnClicked = true
                    //hideKeyboard()
                    
                    // 성공 ? -> Success 표시 (2000ms) 이후 세팅으로 돌아가기
                    // 실패 ? -> 현재 비밀번호가 틀렸을 경우, 알림
                    
                    // TEMP
                    DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTimeInterval.seconds(2)) {
                        resetPasswordSuccess = true
                        //resetPasswordFail = true
                    }
                } label : {
                    Text("Continue")
                        .font(.system(size : 14, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth : .infinity)
                        .background(RoundedRectangle(cornerRadius: 8).fill(newPassword.count > 7 && newPassword.containsCapitals() && newPassword.containsNumbers() && newPassword == newPasswordConfirm ? Color.yellow : Color.gray.opacity(0.5)))
                        .padding()
                }.disabled(newPassword.count > 7 && newPassword.containsCapitals() && newPassword.containsNumbers() ? false : true)
            }
        }.overlay(
            Color.black
                .edgesIgnoringSafeArea(.vertical)
                .overlay(ProgressView())
                .opacity(resetBtnClicked ? 0.5 : 0)
        )
        .navigationBarHidden(true)
        .onDisappear {
            currentPassword = ""
            newPassword = ""
            newPasswordConfirm = ""
            resetPasswordStep = 1
        }.alert(isPresented: $resetPasswordFail) {
            Alert(title: Text("Incorrect Current Password"),
                  message: Text("Please insert correct current password"),
                  dismissButton: .destructive(Text("Retry")) {
                                    currentPassword = ""
                                    newPassword = ""
                                    newPasswordConfirm = ""
                                    resetBtnClicked = false
                                    resetPasswordStep = 1
                                }
            )
        }
            if resetPasswordSuccess {
                VStack {
                    Image(systemName: "checkmark.circle")
                        .foregroundColor(.green)
                        .font(.system(size : 60))
                    Text("Success!")
                        .font(.system(size : 32, weight : .bold))
                        .padding()
                    Text("Your new password has\nbeen successfully changed.")
                }.frame(width : UIScreen.main.bounds.width * 0.7, height : UIScreen.main.bounds.width * 0.7)
                .background(Color.white)
                .cornerRadius(12)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTimeInterval.seconds(2)) {
                        showChagePasswordView = false
                        resetPasswordSuccess = false
                        resetBtnClicked = false
                    }
                }
            }
        }
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
                Text("Back")
                    .opacity(0)
            }.padding()
            .frame(width : UIScreen.main.bounds.width, alignment: .leading)
            .background(Color.white.shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2))
            .padding(.bottom)
            
            if deleteAccountStep == 1 {
                VStack(spacing : 8) {
                    Text("Delete Account")
                        .font(.system(size : 24, weight : .bold))
                        .frame(maxWidth : .infinity, alignment : .leading)
                    Text("Please enter your current password\nto verify it is your account. ")
                        .font(.system(size : 16))
                        .frame(maxWidth : .infinity, alignment : .leading)
                }.padding()
                
                SecureField("Password", text : $currentPassword)
                    .padding(8)
                    .padding(.horizontal, 8)
                    .background(Color.gray.opacity(0.2)) // systemDefaultGray
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                Spacer()
                Button {
                    deleteAccountStep = 2
                } label : {
                    Text("Continue")
                        .font(.system(size : 14, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth : .infinity)
                        .background(RoundedRectangle(cornerRadius: 8).fill(currentPassword.isEmpty ? Color.gray.opacity(0.5) : Color.yellow))
                        .padding()
                }.disabled(currentPassword.isEmpty ? true : false)
            } else {
                VStack(spacing : 8) {
                    Text("Delete Account")
                        .font(.system(size : 24, weight : .bold))
                        .frame(maxWidth : .infinity, alignment : .leading)
                    Text("Your feedback will be important to us.\nHope you come back any time soon!")
                        .font(.system(size : 16))
                        .frame(maxWidth : .infinity, alignment : .leading)
                }.padding()
                
                TextField("Why are you deleting your account?", text : $deleteAccountFeedback)
                    .padding()
                
                Spacer()
                Button {
                    deleteAccountFailAlertType = 1
                    showDeleteAccountAlert = true
                } label : {
                    Text("Continue")
                        .font(.system(size : 14, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth : .infinity)
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color.yellow))
                        .padding()
                }
            }
        }.overlay(
            Color.black
                .edgesIgnoringSafeArea(.vertical)
                .overlay(ProgressView())
                .opacity(deleteAccountBtnClicked ? 0.5 : 0)
        )
        .navigationBarHidden(true)
        .onDisappear {
            currentPassword = ""
            deleteAccountStep = 1
            deleteAccountFeedback = ""
        }
        .alert(isPresented: $showDeleteAccountAlert) {
            if deleteAccountFailAlertType == 1 {
                return Alert(title: Text("Delete Account?"),
                      message: Text("Are you sure you want to delete your account?"),
                      primaryButton: .cancel(Text("Cancel")),
                      secondaryButton: .destructive(Text("Delete")) {
                                                deleteAccountBtnClicked = true
                                                // TEMP
                                                DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTimeInterval.seconds(2)) {
                                                    //deleteAccountFailAlertType = 2 // Fail
                                                    //showDeleteAccountAlert = true
                                                    
                                                    deleteAccountSuccess = true // Active background navigation link
                                                }
                                        }
                )
            } else { //if deleteAccountFailAlertType == 2 {
                return Alert(title: Text("Incorrect Current Password"),
                             message: Text("Please insert correct current password"),
                             dismissButton: .destructive(Text("Retry")) {
                                                    currentPassword = ""
                                                    deleteAccountFeedback = ""
                                                    deleteAccountBtnClicked = false
                                                    deleteAccountStep = 1
                                            }
                )
            }
        }
        //.background(NavigationLink(isActive: $deleteAccountSuccess, destination: LandingView(), label: <#T##() -> _#>))
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
