//
//  MyPageViewModel.swift
//  Nanuri
//
//  Created by Park Gyurim on 2022/01/31.
//

import Foundation
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser
import NaverThirdPartyLogin

class MyPageViewModel : NSObject, ObservableObject {
    @Published var authorizationCodeKakao : String = ""
    @Published var authorizationCodeNaver : String = ""
    
    @Published var profileImage : URL?
    @Published var userMail : String = ""
    @Published var userName : String = ""
    
    func getUserInfo() {
        UserApi.shared.me { [weak self] User, Error in
            if let name = User?.kakaoAccount?.profile?.nickname {
                self?.userName = name
            }
            if let mail = User?.kakaoAccount?.email {
                self?.userMail = mail
            }
            if let profile = User?.kakaoAccount?.profile?.profileImageUrl {
                self?.profileImage = profile
            }
        }
    }
    
    func accountSignOut() {
        UserApi.shared.logout { (error) in
            if let error = error {
                print(error)
            }
            else {
                print("logout() success.")
            }
        }
    }
    
    func accountKakaoUnlink() {
        UserApi.shared.unlink { (error) in
            if let error = error {
                print(error)
            }
            else {
                print("unlink() success.")
            }
        }
    }
}

// Naver Login Delegate - call back
extension MyPageViewModel : UIApplicationDelegate, NaverThirdPartyLoginConnectionDelegate {
    // 로그인에 성공했을 경우 호출
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        print("[Success] : Success Naver Login")
        //getNaverInfo()
        print("App Name : " + NaverThirdPartyLoginConnection.getSharedInstance().appName)
        print("Access Token : " + NaverThirdPartyLoginConnection.getSharedInstance().accessToken)
        print("Token Type : " + NaverThirdPartyLoginConnection.getSharedInstance().tokenType)
    }
    
    // 접근 토큰 갱신
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        NaverThirdPartyLoginConnection
            .getSharedInstance()
            .requestAccessTokenWithRefreshToken()
    }
    
    // 로그아웃 할 경우 호출(토큰 삭제)
    func oauth20ConnectionDidFinishDeleteToken() {
        print("[Success] : Success Naver Logout")
        NaverThirdPartyLoginConnection
            .getSharedInstance()
            .requestDeleteToken()
    }
    
    // 모든 Error
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        print("[Error] :", error.localizedDescription)
    }
}
