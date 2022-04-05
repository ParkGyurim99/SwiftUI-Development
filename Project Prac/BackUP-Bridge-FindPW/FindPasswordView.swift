//
//  FindPasswordView.swift
//  Bridge-iOS
//
//  Created by Park Gyurim on 2021/11/04.
//

import SwiftUI

struct FindPasswordView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = FindPasswordViewModel()
    
    var titleField : some View {
        Text(viewModel.titleText)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(.vertical, 60)
            .foregroundColor(.mainTheme)
            .padding(.bottom, 50)
    }
    var submitButton : some View {
        Button {
            // API Calling and increase buttonAction value
            withAnimation { viewModel.apiCalling(viewModel.buttonAction) }
        } label : {
            Text("Next")
                .fontWeight(.semibold)
                .frame(width : UIScreen.main.bounds.width * 0.8)
                .padding()
                .foregroundColor(.white)
                .background(viewModel.nextButtonValidation(viewModel.buttonAction) ? Color.gray.opacity(0.8) : Color.mainTheme)
                .cornerRadius(20)
                .shadow(radius: 3)
        }.disabled(viewModel.nextButtonValidation(viewModel.buttonAction))
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.systemDefaultGray
            VStack(spacing : 40) {
                // title
                if (viewModel.buttonAction != 3) {
                    titleField
                } else {
                    Image("Check")
                        .resizable()
                        .frame(width : 100, height : 100)
                }
                
                switch viewModel.buttonAction {
                // "Reset Password"
                case 0 :
                    HStack {
                        Image(systemName: "envelope")
                        TextField("Email", text: $viewModel.email)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .accentColor(.mainTheme)
                    }.modifier(SignViewTextFieldStyle())
                
                // "Check your mail box"
                case 1 :
                    HStack {
                        TextField("Enter your code", text: $viewModel.key)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .accentColor(.mainTheme)
                    }.modifier(SignViewTextFieldStyle())
                
                // "Enter your new Password"
                case 2 :
                    VStack (spacing : 20) {
                        HStack {
                            Image(systemName: "lock.fill")
                            if viewModel.showPassword {
                                TextField("Password", text: $viewModel.password)
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    .accentColor(.mainTheme)
                            } else {
                                SecureField("Password", text: $viewModel.password)
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    .accentColor(.mainTheme)
                            }
                            Button {
                                viewModel.showPassword.toggle()
                            } label : {
                                Image(systemName: viewModel.showPassword ? "eye.slash" : "eye")
                                    .foregroundColor(.black)
                            }
                        }.modifier(SignViewTextFieldStyle())
                        HStack {
                            Image(systemName: "lock.fill")
                            if viewModel.showPasswordConfirmation {
                                TextField("Password", text: $viewModel.passwordConfirmation)
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    .accentColor(.mainTheme)
                            } else {
                                SecureField("Password", text: $viewModel.passwordConfirmation)
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    .accentColor(.mainTheme)
                            }
                            Button {
                                viewModel.showPasswordConfirmation.toggle()
                            } label : {
                                Image(systemName: viewModel.showPasswordConfirmation ? "eye.slash" : "eye")
                                    .foregroundColor(.black)
                            }
                        }.modifier(SignViewTextFieldStyle())
                    }
                    
                // Done
                case 3 :
                    Text("You have successfully changed your password")
                        .foregroundColor(.mainTheme)
                        .font(.system(size : 25, weight : .semibold))
                        .padding(20)
                        .padding(.vertical, 10)
                // Got error
                default:
                    Text("Got Error go back to previous page").font(.largeTitle)
                }
                
                if (viewModel.buttonAction != 3) {
                    submitButton
                } else { // complete change password
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label : {
                        Text("Done").modifier(SubmitButtonStyle())
                    }
                }
            } // VStack
            .frame(width : UIScreen.main.bounds.width, height : UIScreen.main.bounds.height * 0.8)
            .background(Color.white)
            .cornerRadius(15)
            .shadow(radius: 15)
            .offset(y : 10)
        } // ZStack
        .edgesIgnoringSafeArea(.vertical)
        .alert(isPresented: $viewModel.inputWrongKey) {
            Alert(title: Text("Wrong Key"),
                  message: Text("Try again with right key"),
                  dismissButton: .default(Text("OK")))
        }
    }
}

struct FindPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        FindPasswordView()
    }
}
