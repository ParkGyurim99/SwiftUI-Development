//
//  ContentView.swift
//  LoginPageEN
//
//  Created by Farukh IQBAL on 25/02/2020.
//  Copyright © 2020 Farukh IQBAL. All rights reserved.
//

import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import SwiftUI

struct logIn : View {

    @State var index = -1
    @Namespace var name

    var body: some View{
//        NavigationView {
            VStack{
                if (index == -1 || index == 1) {
                    Text("WIT")
                        .font(.system(size : 30))
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .frame(width: 70)
                    HStack(spacing: 0){
                        Button(action: {
                            withAnimation(.spring()){ index = -1 }
                        }) {
                            VStack{
                                Text("Login")
                                    .font(.system(size: 20))
                                    .fontWeight(.bold)
                                    .foregroundColor(index == -1 ? .black : .gray)
                                ZStack{
                                    // slide animation....
                                    Capsule()
                                    .fill(Color.black.opacity(0.04))
                                    .frame( height: 4)

                                    if index == -1 {
                                        Capsule()
                                            .fill(Color.black)
                                            .frame( height: 4)
                                            .matchedGeometryEffect(id: "Tab", in: name)
                                    }
                                } // ZStack
                            } // VStack
                        } // Button

                        Button(action: {
                            withAnimation(.spring()){ index = 1 }
                        }) {
                            VStack{
                                Text("Sign Up")
                                    .font(.system(size: 20))
                                    .fontWeight(.bold)
                                    .foregroundColor(index == 1 ? .black : .gray)

                                ZStack{
                                    // slide animation....
                                    Capsule()
                                        .fill(Color.black.opacity(0.04))
                                        .frame( height: 4)
                                    if index == 1 {
                                        Capsule()
                                            .fill(Color.black)
                                            .frame( height: 4)
                                            .matchedGeometryEffect(id: "Tab", in: name)
                                    }
                                } // Z
                            } // B
                        } // Button
                    } // HStack
                    .padding(.top,30)
                } // if
                
                // Login View...

                // Changing Views Based On Index...

                if index == -1{
                    Login(index:$index)
                        .navigationBarHidden(true)
                }
                else if index == 1{
                    SignUp(index:$index)
                        .navigationBarHidden(true)
                }
                else{
                    Home()
                }
            }
//        } // navigationview
    }
}


struct Login : View {
    @Binding var index : Int
    @State var id = ""
    @State var password = ""
    @State private var error: String = ""
    @State private var showingAlert = false
    @State private var alertTitle: String = "Oh No!!"
    
    func clear(){
        self.password = ""
        self.id = ""
    }
    func errorCheck() -> String? {
        if id.trimmingCharacters(in: .whitespaces).isEmpty || password.trimmingCharacters(in: .whitespaces).isEmpty
        {
            return "Check your fill"
        }
        return nil
        
    }
    func signIn() {
        if let error = errorCheck(){
            self.error = error
            self.showingAlert=true
            return
        }
        AuthService.signIn(email: id, password: password, onSuccess: {
            (user) in
            print("ok")
            self.clear()
            index=2
        }){
            (errorMessage) in
            print("error")
            self.error = errorMessage
            self.showingAlert = true
            return
        }
    }

    var body: some View{
        VStack{
            HStack{
                Spacer().frame(width : 35)
                VStack(alignment: .leading, spacing: 12) {
                    Text("Hello,")
                        .fontWeight(.bold)
                    Text("Here is WIT")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("당신의 첫 인상을 관리합니다.")
                        .font(.system(size: 14))
                        .fontWeight(.bold)
                        .foregroundColor(Color.gray)
                }
//                Image(systemName: "face.smiling.fill")
//                    .frame(width: 100, height: 100)
                Spacer(minLength: 0)
            }
            .padding(.horizontal,25)
            .padding(.top,30)

            VStack(alignment: .leading, spacing: 15) {

                Text("e-mail")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.black)

                TextField("e-mail", text: $id)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5)
                    // shadow effect...
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x:0, y:5)
                    .shadow(color: Color.black.opacity(0.08), radius:5, x:0, y:-5)

                Text("Password")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.black)

                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5)
                    // shadow effect...
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x:0, y:5)
                    .shadow(color: Color.black.opacity(0.08), radius:5, x:0, y:-5)
//
//                Button(action: {}) {
//
//                    Text("Forget Password")
//                        .font(.system(size: 14))
//                        .fontWeight(.bold)
//                        .foregroundColor(Color.black)
//                }
//                .padding(.top,10)
            }
            .padding(.horizontal,25)
            .padding(.top,25)

            // Login Button....

            Button(action: signIn) {
                Text("Login")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 50)
                    .background(Color.gray)
                    .cornerRadius(8)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x:0, y:5)
                    .shadow(color: Color.black.opacity(0.08), radius: 5, x:0, y:-5)
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text(alertTitle), message: Text(error), dismissButton: .default(Text("OK")))
            }
            .padding(.horizontal,25)
            .padding(.top,25)
        }
    }
}
struct SignUp : View {
    @Binding var index : Int
    @State var id = ""
    @State var password = ""
    @State var username = ""
    @State private var postImage: Image?
    @State private var pickedImage: Image?
    @State private var showingActionSheet = false
    @State private var showingImagePicker = false
    @State private var imageData: Data = Data()
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var error: String = ""
    @State private var showingAlert = false
    @State private var alertTitle: String = "Oh No!!"
    @State private var dscText = ""
    @State private var titleText = ""
    
    func loadImage(){
        guard let inputImage = pickedImage else{ return}
        
        postImage = inputImage
    }
    func clear(){
        self.password = ""
        self.id = ""
        self.username = ""
        self.postImage = Image(systemName: "photo.fill")
    }
    func errorCheck() -> String? {
        if id.trimmingCharacters(in: .whitespaces).isEmpty || imageData.isEmpty || password.trimmingCharacters(in: .whitespaces).isEmpty || username.trimmingCharacters(in: .whitespaces).isEmpty
        {
            return "Check your fill"
        }
        return nil
    }
    func signUp() {
        if let error = errorCheck(){
            self.error = error
            self.showingAlert=true
            return
        }
        AuthService.signUp(username: username, email: id, password: password, imageData: imageData, onSuccess: {
            (user) in
            print("ok")
            self.clear()
        }){
            (errorMessage) in
            print("error")
            self.error = errorMessage
            self.showingAlert = true
            return
        }
    }
    
    var body: some View{
        VStack{
        VStack(alignment: .leading, spacing: 15) {
            
            Text("Profile Photo")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.black)
            VStack{
                if postImage != nil {
                    Text("Image Selected, Click Again to Select Photo")
                        .opacity(0.1)
                        .frame(width: UIScreen.main.bounds.width * 0.85, height: 27)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(5)
                        // shadow effect...
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x:0, y:5)
                        .shadow(color: Color.black.opacity(0.08), radius: 5, x:0, y:-5)
                        .onTapGesture {
                            self.showingActionSheet = true
                        }
                } else {
                    HStack {
                        Image(systemName: "photo.fill")
                            .resizable()
                            .frame(width : 20, height: 17)
                            .opacity(0.5)

                        Text("Click Here to Select Photo")
                            .opacity(0.5)
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.85, height: 27)
                    .onTapGesture {
                        self.showingActionSheet = true
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5)
                    // shadow effect...
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x:0, y:5)
                    .shadow(color: Color.black.opacity(0.08), radius: 5, x:0, y:-5)
                }
            }

            Text("e-mail")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.black)

            TextField("e-mail", text: $id)
                .padding()
                .background(Color.white)
                .cornerRadius(5)
                // shadow effect...
                .shadow(color: Color.black.opacity(0.1), radius: 5, x:0, y:5)
                .shadow(color: Color.black.opacity(0.08), radius: 5, x:0, y:-5)

            Text("Password")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.black)

            SecureField("Password", text: $password)
                .padding()
                .background(Color.white)
                .cornerRadius(5)
                // shadow effect...
                .shadow(color: Color.black.opacity(0.1), radius: 5, x:0, y:5)
                .shadow(color: Color.black.opacity(0.08), radius: 5, x:0, y:-5)
            
            Text("Username")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.black)

            TextField("Please type your first name", text: $username)
                .padding()
                .background(Color.white)
                .cornerRadius(5)
                            // shadow effect...
                .shadow(color: Color.black.opacity(0.1), radius: 5, x:0, y:5)
                .shadow(color: Color.black.opacity(0.08), radius: 5, x:0, y:-5)
        }
        .padding()
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage){
            ImagePicker(pickedImage: self.$pickedImage, showingImagePicker: self.$showingImagePicker, imageData:self.$imageData)
        }.actionSheet(isPresented: $showingActionSheet){
            ActionSheet(title: Text(""),buttons: [
                .default(Text("Choose")){
                    self.sourceType = .photoLibrary
                    self.showingImagePicker = true
                },
                .default(Text("Take a Photo")){
                    self.sourceType = .camera
                    self.showingImagePicker = true
                }, .cancel()
            ])
        }

        // Login Button....

        Button(action:signUp) {
            Text("Sign Up")
                .font(.system(size: 20))
                .foregroundColor(.white)
                .fontWeight(.bold)
                .padding(.vertical)
                .frame(width: UIScreen.main.bounds.width - 50)
                .background(Color.gray)
                .cornerRadius(8)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x:0, y:5)
                .shadow(color: Color.black.opacity(0.08), radius: 5, x:0, y:-5)
        }.alert(isPresented: $showingAlert) {
            Alert(title: Text(alertTitle), message: Text(error), dismissButton: .default(Text("OK")))
        }
        .padding(.horizontal,25)
        .padding(.top,25)

        // Social Buttons...

        }
    }
}
