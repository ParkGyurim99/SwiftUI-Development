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
import NaverThirdPartyLogin

struct MyPageView: View {
    @StateObject private var viewModel = MyPageViewModel()
    
    var Title : some View {
        HStack {
            Text("마이 페이지")
                .font(.largeTitle)
                .fontWeight(.bold)
            Spacer()
            Image(systemName: "gearshape.fill")
                .font(.system(size: 25))
        }
    }
    var Profile : some View {
        VStack {
            Spacer()
            Divider()
            //MARK: Kakao Auth API TEMP
            Button {
                //카카오톡이 깔려있는지 확인하는 함수
                if (UserApi.isKakaoTalkLoginAvailable()) {
                    //카카오톡이 설치되어있다면 카카오톡을 통한 로그인 진행
                    UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                        //print(oauthToken)
                        //print(error)
                        viewModel.getUserInfo()
                        //isSignIn = true
                    }
                } else {
//                        //카카오톡이 설치되어있지 않다면 사파리에서 카카오 계정을 통한 로그인 진행
//                        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
//                            //print(oauthToken)
//                            //print(error)
//                            viewModel.getUserInfo()
//                            //isSignIn = true
//                        }
                    
                    // Appstore에서 카카오톡 열기
                    if let url = URL(string: "itms-apps://itunes.apple.com/app/id362057947"), UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:])
                    }
                }
            } label : {
                Image("kakao_login")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(20)
            }.frame(width: UIScreen.main.bounds.width * 0.9)
            
            Button {
                if NaverThirdPartyLoginConnection
                    .getSharedInstance()
                    .isPossibleToOpenNaverApp() // Naver App이 깔려있는지 확인하는 함수
                {
                    NaverThirdPartyLoginConnection.getSharedInstance().delegate = viewModel.self
                    NaverThirdPartyLoginConnection
                        .getSharedInstance()
                        .requestThirdPartyLogin()
                } else { // 네이버 앱 안깔려져 있을때
                    // Appstore에서 네이버앱 열기
                    //NaverThirdPartyLoginConnection.getSharedInstance().openAppStoreForNaverApp()
                    
                    // 브라우저로 네이버 로그인 열기
                    UIApplication.shared.open(
                        URL(string: "https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=" + kConsumerKey + "&redirect_uri=nanuri://naverAuth")!,
                        options: [:]
                    )
                }
            } label : {
                Image("naver_login")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(20)
            }.frame(width: UIScreen.main.bounds.width * 0.9)
        }
    }
    var TokenStatus : some View {
        VStack {
            Divider()
            Text("Kakao login auth code : \n" + viewModel.authorizationCodeKakao)
                .fontWeight(.semibold)
                .frame(maxWidth : UIScreen.main.bounds.width * 0.9, alignment : .leading)
                .padding()
                .background(Color.yellow.opacity(0.7))
                .cornerRadius(20)
                
            Text("Naver login auth code : \n" + viewModel.authorizationCodeNaver)
                .fontWeight(.semibold)
                .frame(maxWidth : UIScreen.main.bounds.width * 0.9, alignment : .leading)
                .padding()
                .background(Color.green.opacity(0.7))
                .cornerRadius(20)
            Divider()
        }
    }
    var body: some View {
        VStack {
            Title
//            Text("My Classes (#)")
//                .font(.system(.title3, design: .rounded))
//                .fontWeight(.semibold)
//                .frame(maxWidth : .infinity, alignment: .leading)
//            ScrollView(.horizontal) {
//                HStack {
//                    ForEach(0..<3, id : \.self) { _ in
//                        Color.gray
//                            .opacity(0.5)
//                            .frame(width: 120, height: 120)
//                            .cornerRadius(20)
//                    }
//                }
//            }
            TokenStatus
            
            // Kakao
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
                    Color.white
                        .frame(width: 70, height: 70)
                        .clipShape(Circle())
                }

                VStack(alignment : .leading, spacing : 10) {
                    Text(viewModel.userName)
                        .font(.system(.title2, design: .rounded))
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    Text(viewModel.userMail)
                        .font(.system(.subheadline, design: .rounded))
                        .foregroundColor(.gray)
                }.padding(.leading, 10)
                Spacer()
                if AuthApi.hasToken() {
                    Image(systemName : "k.circle.fill")
                        .foregroundColor(.yellow)
                        .font(.system(size : 20))
                }
            }
            HStack {
                Text("Kakao")
                    .foregroundColor(.yellow)
                    .fontWeight(.semibold)
                Spacer()
                Button {
                    _ = AuthController.handleOpenUrl(
                        url: URL(string : "kakaoc95be0b24be89d4167b238b296e8396d://oauth?code=" + String(viewModel.authorizationCodeKakao))!)
                } label : {
                    Text("토큰발급")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(20)
                }
                
                Button {
                    viewModel.accountSignOut()
                } label : {
                    Text("로그아웃")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(20)
                }
                
                Button {
                    viewModel.accountKakaoUnlink()
                } label : {
                    Text("연결끊기")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.darkGray)
                        .cornerRadius(20)
                }
            }
            
            Divider()
            // Naver
            HStack {
                if let profileImage = viewModel.profileImageNaver {
                    URLImage(profileImage) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 70, height: 70)
                            .clipShape(Circle())
                    }
                } else {
                    Color.white
                        .frame(width: 70, height: 70)
                        .clipShape(Circle())
                }

                VStack(alignment : .leading, spacing : 10) {
                    Text(viewModel.userNameNaver)
                        .font(.system(.title2, design: .rounded))
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    Text(viewModel.userMailNaver)
                        .font(.system(.subheadline, design: .rounded))
                        .foregroundColor(.gray)
                }.padding(.leading, 10)
                Spacer()
                if viewModel.isNaverLogined {
                    Image(systemName : "n.circle.fill")
                        .foregroundColor(.green)
                        .font(.system(size : 20))
                }
            }
            HStack {
                Text("Naver")
                    .foregroundColor(.green)
                    .fontWeight(.semibold)
                Spacer()
                Button {
                    NaverThirdPartyLoginConnection
                        .getSharedInstance()
                        .receiveAccessToken(
                            URL(string : "nanuri://thirdPartyLoginResult?version=2&code=0&authCode=" + viewModel.authorizationCodeNaver)
                        )
                } label : {
                    Text("토큰발급")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(20)
                }
                
                Button {
                    NaverThirdPartyLoginConnection.getSharedInstance().resetToken()
                    viewModel.isNaverLogined = false
                } label : {
                    Text("로그아웃")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(20)
                }
                
                Button {
                    NaverThirdPartyLoginConnection.getSharedInstance().requestDeleteToken() // 연동 해제
                    viewModel.isNaverLogined = false
                } label : {
                    Text("연결끊기")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.darkGray)
                        .cornerRadius(20)
                }
            }
            Profile
        } // VStack
        .onAppear{ viewModel.getUserInfo() }
        .padding()
        .navigationBarHidden(true)
        .onOpenURL { url in // code를 파라미터로해서 서버에 jwt 발급 요청
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                //kakaoc95be0b24be89d4167b238b296e8396d://oauth?code=UsV-pWTMvFKmWyklGZu1QCbRuhU2Jl2LNYo4EqMXsZcvfyPMWowoi7eRF9a2kb2WvrX9FAo9dNkAAAF-yh8FEw
                // 카카오 로그인 리다이렉트일 경우
                // ex) kakaoc95be0b24be89d4167b238b296e8396d://oauth?
                //      code=c5ih7yqbTO3g0jBfVHcbPpNkurHZHUEcotDsqchDIx1avCIgwSGlDYltCCalX6n4CGv1sQo9cpcAAAF-yUFuzA

                // url : redirect uri 랑 authorization code
                print("kakao authorization code -")
                viewModel.authorizationCodeKakao = url.oauthResult().code ?? ""
                
                // -- Access Token 발급 요청
                //_ = AuthController.handleOpenUrl(url: url)
            } else if NaverThirdPartyLoginConnection
                        .getSharedInstance()
                        .isNaverThirdPartyLoginAppschemeURL(url) {
                // 네이버 로그인 리다이렉트일 경우
                // ex) nanuri://thirdPartyLoginResult?version=2&code=0&authCode=lDDBH4j7LV1iMWGUWH
                print("naver authorization code")
                print(url.absoluteString)
                if let authCode = url.absoluteString.components(separatedBy: "&").last?.components(separatedBy: "=").last {
                    viewModel.authorizationCodeNaver = authCode
                }
                
                // -- Access Token 발급 요청
                //NaverThirdPartyLoginConnection
                //    .getSharedInstance()
                //    .receiveAccessToken(url)
            }
        }
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView()
    }
}
