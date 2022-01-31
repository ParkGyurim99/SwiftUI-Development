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

final class MyPageViewModel : ObservableObject {
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
