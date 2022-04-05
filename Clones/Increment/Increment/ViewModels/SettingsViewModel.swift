//
//  SettingsViewModel.swift
//  Increment
//
//  Created by Park Gyurim on 2021/09/04.
//

import Combine
import SwiftUI

final class SettingsViewModel : ObservableObject {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @Published private(set) var itemViewModels : [SettingsItemViewModel] = []
    @Published var loginsignupPushed = false
    
    private let userService : UserServiceProtocol
    private var cancellables : [AnyCancellable] = []
    
    let title = "Settings"
    
    init(userService : UserServiceProtocol = UserService()) {
        self.userService = userService
    }
    func item(at index : Int) -> SettingsItemViewModel {
        return itemViewModels[index]
    }
    
    func tappedItem(at index : Int) {
        switch itemViewModels[index].type {
        case .account :
            guard userService.currentUser?.email == nil else { return }
            loginsignupPushed = true
        case .mode :
            isDarkMode.toggle()
            buildItem()
            // change mode between light mode / dark mode
        case .logout :
            print("log out")
            userService.logout().sink { completion in
                switch completion {
                case let .failure(error) :
                    print(error.localizedDescription)
                case .finished :
                    break
                }
            } receiveValue: { _ in }
            .store(in : &cancellables)
        default :
            break
        }
    }
    
    func buildItem() {
        itemViewModels = [
            .init(title: userService.currentUser?.email ?? "Create Account", iconName: "person.circle", type: .account),
            .init(title: "Switch to \(isDarkMode ? "Ligth" : "Dark") Mode", iconName: "lightbulb", type: .mode),
            .init(title: "Privacy Policy", iconName: "shield", type: .privacy)
        ]
        if userService.currentUser?.email != nil {
            itemViewModels += [.init(title: "Log Out", iconName: "arrowshape.turn.up.left", type: .logout)]
        }
    }

    func onAppear() {
        buildItem()
    }
}
