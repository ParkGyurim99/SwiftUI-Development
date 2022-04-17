//
//  ContentView.swift
//  KeyboardObserver
//
//  Created by Park Gyurim on 2022/04/17.
//

import SwiftUI

struct ContentView: View {
    @State var password = ""
    @State var email = ""
    @State var isEditing = false
    
    var titleField : some View {
        Text("Title")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(.yellow)
            .padding(.vertical, 60)
    }
    var emailField : some View {
        HStack {
            Image(systemName: "envelope")
            TextField("Email", text: $email, onEditingChanged: { editStatus in
                withAnimation { isEditing = editStatus }
            }).autocapitalization(.none)
            .accentColor(.yellow)
            .keyboardType(.emailAddress)
            
        }.frame(width : UIScreen.main.bounds.width * 0.8)
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 3)
    }
    var passwordField : some View {
        HStack {
            Image(systemName: "lock")
//            TextField("Password", text: $password, onEditingChanged: { editStatus in
//                withAnimation {isEditing = editStatus
//                } })
//                .autocapitalization(.none)
//                .accentColor(.yellow)
            SecureField("Password", text: $password, onCommit: {
                withAnimation { isEditing = false }
            } )
                .autocapitalization(.none)
                .accentColor(.yellow)
                .onTapGesture { withAnimation { isEditing = true } }
                .onChange(of: password) { _ in withAnimation { isEditing = true } }
            Button {
                
            } label : {
                Image("eye")
                    .foregroundColor(.black)
            }
        }.frame(width : UIScreen.main.bounds.width * 0.8)
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 3)
    }
    var remeberButton : some View {
        HStack {
            Spacer()
            Button {
                
            } label : {
                Image(systemName: "checkmark.square.fill")
                    .foregroundColor(.gray)
            }
            Text("Remember Me").foregroundColor(.gray)
        }.padding(.horizontal, 30)
    }
    var nextButton : some View {
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
    var findPassword : some View {
        NavigationLink(destination: Text("find pw")){
            Text("Forgot Password?")
                .fontWeight(.semibold)
                .foregroundColor(.yellow)
                .padding(10)
        }
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.gray.opacity(0.5)
            
            VStack(spacing : 30) {
                titleField
                emailField
                passwordField
                remeberButton
                nextButton
                Spacer()
                findPassword
                Spacer()
            }
            .frame(width : UIScreen.main.bounds.width, height : UIScreen.main.bounds.height * 0.8)
            .background(Color.white.onTapGesture {
                    withAnimation { isEditing = false }
                    hideKeyboard()
                }
            )
            .cornerRadius(15)
            .shadow(radius: 15)
            .padding(.bottom, isEditing ? UIScreen.main.bounds.height * 0.08 : 0)
        }.edgesIgnoringSafeArea(.vertical)
        .navigationTitle(Text(""))
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
