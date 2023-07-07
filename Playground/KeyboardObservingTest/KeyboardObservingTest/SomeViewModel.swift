//
//  SomeViewModel.swift
//  KeyboardObservingTest
//
//  Created by Park Gyurim on 2023/07/07.
//

import Foundation
import UIKit
import Combine

final class SomeViewModel: ObservableObject {
    @Published var keyboardHeight: CGFloat = 0
    @Published var text1: String = ""
    @Published var text2: String = ""
    
    private var cancellable: Set<AnyCancellable> = []
    
    init() { setKeyboardHeightObserver() }
    
    private func setKeyboardHeightObserver() {
        NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillChangeFrameNotification)
            .map {
                guard let info = $0.userInfo,
                      let keyboardFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
                else { return CGFloat(0) }

                print("→", keyboardFrame)

                return keyboardFrame.height
            }.assign(to: \.keyboardHeight, on: self)
            .store(in: &cancellable)
        
        NotificationCenter.default.publisher(for: UIWindow.keyboardDidHideNotification)
            .map { _ in 0 }
            .assign(to: \.keyboardHeight, on: self)
            .store(in: &cancellable)
    }
}
