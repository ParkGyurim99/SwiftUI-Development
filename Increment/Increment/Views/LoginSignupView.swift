//
//  LoginSignupView.swift
//  Increment
//
//  Created by Park Gyurim on 2021/09/05.
//

import SwiftUI

struct LoginSignupView : View {
    @ObservedObject var viewModel : LoginSignupViewModel
    // automatically initialize viewModel when we call this view with parameter viewModel
    var emailTextField : some View {
        TextField("Email", text : $viewModel.emailText)
            .modifier(TextFieldCustomRoundedStyle())
    }
    var passwordTextField : some View {
        SecureField("Password", text: $viewModel.passwordText)
            .modifier(TextFieldCustomRoundedStyle())
    }
    var actionButton : some View {
        Button(viewModel.buttonTitle) {
            
        }.padding()
        .frame(maxWidth : .infinity)
        .foregroundColor(.white)
        .background(Color(.systemPink))
        .cornerRadius(15)
        .padding()
    }
    var body : some View {
        VStack {
            Text(viewModel.title)
                .font(.largeTitle)
                .fontWeight(.bold)
            Text(viewModel.subTitle)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.secondary)
            Spacer()
                .frame(height : 50)
            emailTextField
            passwordTextField
            actionButton
            Spacer()
        }.padding()
    }
}
struct LoginSignupView_Previews : PreviewProvider {
    static var previews : some View {
        NavigationView {
            LoginSignupView(viewModel: .init(mode: .login))
                .preferredColorScheme(.dark)
        }
    }
}
