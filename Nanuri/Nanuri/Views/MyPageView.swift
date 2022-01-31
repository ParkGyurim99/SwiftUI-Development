//
//  MyPageView.swift
//  Nanuri
//
//  Created by Park Gyurim on 2022/01/28.
//

import SwiftUI
import URLImage
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

struct MyPageView: View {
    @AppStorage("isSignIn") var isSignIn = false
    
    @StateObject private var viewModel = MyPageViewModel()
    
    var Title : some View {
        HStack {
            Text("My Page")
                .font(.largeTitle)
                .fontWeight(.bold)
                //.frame(maxWidth : .infinity, alignment: .leading)
            Spacer()
            Image(systemName: "gearshape.fill")
                .font(.system(size: 25))
        }
    }
    var Profile : some View {
        VStack {
            Divider()
            if !isSignIn {
                //MARK: Kakao Auth API TEMP
                Button {
                    //카카오톡이 깔려있는지 확인하는 함수
                    if (UserApi.isKakaoTalkLoginAvailable()) {
                        //카카오톡이 설치되어있다면 카카오톡을 통한 로그인 진행
                        UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                            //print(oauthToken)
                            //print(error)
                            viewModel.getUserInfo()
                            isSignIn = true
                        }
                    } else {
                        //카카오톡이 설치되어있지 않다면 사파리에서 카카오 계정을 통한 로그인 진행
                        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                            //print(oauthToken)
                            //print(error)
                            viewModel.getUserInfo()
                            isSignIn = true
                        }
                    }
                } label : {
                    Image("kakao_login_large_wide")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width : UIScreen.main.bounds.width * 0.9)
                        .padding(.vertical, 10)
                }
            } else {
                HStack {
                    if let profileImage = viewModel.profileImage {
                        URLImage(profileImage) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 70, height: 70)
                                .clipShape(Circle())
                        }
                    } else {
                        Image(systemName: "person.fill")
                            .font(.system(size: 25))
                            .padding()
                            .frame(width: 70, height: 70)
                            .foregroundColor(.white)
                            .background(Color.darkGray)
                            .clipShape(Circle())
                    }

                    VStack(alignment : .leading, spacing : 10) {
                        HStack(spacing : 5) {
                            Text(viewModel.userName)
                                .font(.system(.title2, design: .rounded))
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                            Image("kakao_small_logo")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width : 30, height : 15)
                                .cornerRadius(5)
                        }
                        Text(viewModel.userMail)
                            .font(.system(.subheadline, design: .rounded))
                            .foregroundColor(.gray)
                    }.padding(.leading, 10)
                    Spacer()
                }.padding(.vertical, 10)
            }
            Divider()
        }.padding(.bottom, 20)
        //.onOpenURL { url in
        //    if (AuthApi.isKakaoTalkLoginUrl(url)) { _ = AuthController.handleOpenUrl(url: url) }
        //}
    }
    
    var body: some View {
        VStack {
            Title
            Profile
            
            Text("My Classes (#)")
                .font(.system(.title3, design: .rounded))
                .fontWeight(.semibold)
                .frame(maxWidth : .infinity, alignment: .leading)
                
            ScrollView(.horizontal) {
                HStack {
                    ForEach(0..<3, id : \.self) { _ in
                        Color.gray
                            .opacity(0.5)
                            .frame(width: 120, height: 120)
                            .cornerRadius(20)
                    }
                }
            }
            Spacer()
            if isSignIn {
                Divider()
                Button {
                    viewModel.accountSignOut()
                    isSignIn = false
                } label : {
                    Text("로그아웃")
                        .fontWeight(.semibold)
                        .foregroundColor(.red)
                        .padding()
                }
                Divider()
            }
            Spacer()
        } // VStack
        .onAppear{ viewModel.getUserInfo() }
        .padding()
        .navigationBarHidden(true)
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView()
    }
}
