//
//  SignUpView.swift
//  KeyboardObserver
//
//  Created by Park Gyurim on 2022/04/18.
//

import SwiftUI

struct SignUpView: View {
    @StateObject var viewModel = SignUpViewModel()
    
    var titleField : some View {
        Text("Title")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(.vertical, 30)
            .foregroundColor(Color.yellow)
    }
    var nameField : some View {
        HStack {
            Image(systemName: "person")
                .foregroundColor(Color.yellow)
//            TextField("name", text: $viewModel.name,
//                      onEditingChanged: { editStatus in
//                            withAnimation {
//                                viewModel.isEditing = editStatus
//                            }
//            })
            TextField("name", text: $viewModel.name,
                      onCommit: {
                withAnimation { viewModel.isEditing = false }
            }).disableAutocorrection(true)
            .autocapitalization(.none)
            .accentColor(.yellow)
            .onTapGesture { withAnimation { viewModel.isEditing = true } }
            .onChange(of: viewModel.name) { _ in withAnimation { viewModel.isEditing = true } }
        }.frame(width : UIScreen.main.bounds.width * 0.8)
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 3)
    }
    var emailField : some View {
        HStack {
            Image(systemName: "envelope")
                .foregroundColor(Color.yellow)
            TextField("mail", text: $viewModel.email,
                      onCommit: {
                withAnimation { viewModel.isEditing = false }
            }).disableAutocorrection(true)
            .autocapitalization(.none)
            .accentColor(.yellow)
            .keyboardType(.emailAddress)
            .onTapGesture { withAnimation { viewModel.isEditing = true } }
            .onChange(of: viewModel.email) { _ in withAnimation { viewModel.isEditing = true } }
        }.frame(width : UIScreen.main.bounds.width * 0.8)
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 3)
    }
    var passwordField : some View {
        HStack {
            Image(systemName: "lock")
                .foregroundColor(Color.yellow)
                SecureField("Password", text: $viewModel.password,
                            onCommit: { withAnimation { viewModel.isEditing = false } } )
                    .autocapitalization(.none)
                    .accentColor(.yellow)
                    .onTapGesture { withAnimation { viewModel.isEditing = true } }
                    .onChange(of: viewModel.password) { _ in withAnimation { viewModel.isEditing = true } }
            Button {
                
            } label : {
                Image(systemName: "eye")
                    .foregroundColor(.black)
            }
        }
        .frame(width : UIScreen.main.bounds.width * 0.8)
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 3)
    }
    
    var verifyPasswordField : some View {
        HStack {
            Image(systemName: "lock")
            SecureField("Password", text: $viewModel.passwordConfirm,
                        onCommit: { withAnimation { viewModel.isEditing = false } } )
                .autocapitalization(.none)
                .accentColor(.yellow)
                .onTapGesture { withAnimation { viewModel.isEditing = true } }
                .onChange(of: viewModel.passwordConfirm) { _ in withAnimation { viewModel.isEditing = true } }
            Button {
                
            } label : {
                Image(systemName: "eye")
                    .foregroundColor(.black)
            }
        }
        .frame(width : UIScreen.main.bounds.width * 0.8)
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 3)
    }
    
    var nextButton : some View {
        NavigationLink(destination: Text("Next View")) {
            Button {

            } label : {
                Text("Next")
                    .fontWeight(.semibold)
                    .frame(width : UIScreen.main.bounds.width * 0.8)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.yellow)
                    .cornerRadius(20)
                    .shadow(radius: 3)
            }
        }
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.gray.opacity(0.5) // background
            
            VStack(spacing : 30) {
                Spacer()
                titleField
                nameField
                emailField
                passwordField
                verifyPasswordField
                Text("PasswordLimit")
                    .foregroundColor(Color.gray)
                    .font(.system(size: 9))
                    .padding(-20)
                nextButton
                Divider()
                HStack {
                    Text("AskExistingAccount")
                    NavigationLink(destination: SignInView()) {
                        Text("SignIn")
                            .foregroundColor(.yellow)
                    }
                }.padding(.bottom, 30)
            }
            .frame(width : UIScreen.main.bounds.width, height : UIScreen.main.bounds.height * 0.8)
            .padding(.bottom)
            .background(Color.white.edgesIgnoringSafeArea(.all))
            .cornerRadius(15)
            .shadow(radius: 15)
            .padding(.bottom, viewModel.isEditing ? viewModel.paddingHeight : 0)
        }.overlay(
            VStack(spacing : 0) {
                Spacer()
                Color.white
                    .frame(height : 45)
            }.edgesIgnoringSafeArea(.bottom)
        )
        .edgesIgnoringSafeArea(.all)
        .onTapGesture {
            hideKeyboard()
        }
    }
}

