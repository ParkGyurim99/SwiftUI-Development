//
//  SignUpViewModel.swift
//  KeyboardObserver
//
//  Created by Park Gyurim on 2022/04/18.
//

import SwiftUI

final class SignUpViewModel : ObservableObject {
    @Published var password = ""
    @Published var passwordConfirm = ""
    @Published var email = ""
    @Published var name = ""
    @Published var isEditing = false
    
    var paddingHeight : CGFloat {
        if #available(iOS 15.0, *) { return 0 }
        else { return UIScreen.main.bounds.height * 0.2 }
    }
}
