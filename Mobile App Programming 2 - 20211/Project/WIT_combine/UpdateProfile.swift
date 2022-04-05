//
//  ContentView.swift
//  LoginPageEN
//
//  Created by Farukh IQBAL on 25/02/2020.
//  Copyright © 2020 Farukh IQBAL. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import FirebaseAuth

struct UpdateProfile : View {
    @State var index = 0
    @Namespace var name
    var body: some View{
                NewProfile()
                    .navigationBarTitle(Text("회원 정보 수정"), displayMode: .inline)
    }
}

struct NewProfile : View {

    @State var user = "UserName" // Binding으로 바꿔야할듯?
    @State var password = ""
    @State var password2 = ""
    @State var comment = ""
//    @State var age = ""
//    @State var gender = ""
//    var genders = ["Man", "Woman"]

    var body: some View{

        VStack{

            HStack{

                VStack(alignment: .leading, spacing: 12) {
                    
                    Text("\(Auth.auth().currentUser?.displayName ?? "undefined" )") //아이디 출력
                        .font(.title)
                        .fontWeight(.bold)

                    Button(action: {}) {

                        Text("당신의 첫 인상을 관리합니다.")
                            .font(.system(size: 14))
                            .fontWeight(.bold)
                            .foregroundColor(Color.gray)
                    }
                }
                Spacer(minLength: 0)


                WebImage(url: URL(string:Auth.auth().currentUser?.photoURL!.absoluteString ?? "")!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
//                    .overlay(Circle().stroke(Color.yellow, lineWidth: 5))
                    .shadow(radius: 5)
        }
        .padding(.horizontal,25)
        .padding(.top,30)

        VStack(alignment: .leading, spacing: 15) {

            Text("비밀번호 변경")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.black)

            SecureField("Password to be changed", text: $password)
                .padding()
                .background(Color.white)
                .cornerRadius(5)
                            // shadow effect...
                .shadow(color: Color.black.opacity(0.1), radius: 5, x:0, y:5)
                .shadow(color: Color.black.opacity(0.08), radius: 5, x:0, y:-5)

            SecureField("Type password again", text: $password2)
                .padding()
                .background(Color.white)
                .cornerRadius(5)
                            // shadow effect...
                .shadow(color: Color.black.opacity(0.1), radius: 5, x:0, y:5)
                .shadow(color: Color.black.opacity(0.08), radius: 5, x:0, y:-5)
                
            
            Text("자기소개")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.black)

            TextField("Please write down your state.", text: $comment)
                .frame(height: 150)
                .padding()
                .background(Color.white)
                .cornerRadius(5)
                            // shadow effect...
                .shadow(color: Color.black.opacity(0.1), radius: 5, x:0, y:5)
                .shadow(color: Color.black.opacity(0.08), radius: 5, x:0, y:-5)
            }
            .padding(.horizontal,25)
            .padding(.top,25)
            
            Spacer()
                .frame(height : 40)
            HStack {
                Button(action: {}) {

                    Text("저장")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width-50)
                }
            }
            .background(Color.secondary)
            .cornerRadius(8)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x:0, y:5)
            .shadow(color: Color.black.opacity(0.08), radius: 5, x:0, y:-5)
        }
        .padding(.horizontal,25)
    }
}
