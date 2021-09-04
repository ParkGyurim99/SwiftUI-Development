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
    let title = "Settings"
    
    func item(at index : Int) -> SettingsItemViewModel {
        return itemViewModels[index]
    }
    
    func tappedItem(at index : Int) {
        switch itemViewModels[index].type {
        case .mode :
            isDarkMode.toggle()
            buildItem()
            // change mode between light mode / dark mode
        default :
            break
        }
    }
    func buildItem() {
        itemViewModels = [
            .init(title: "Create Account", iconName: "person.circle", type: .account),
            .init(title: "Switch to \(isDarkMode ? "Ligth" : "Dark") Mode", iconName: "lightbulb", type: .mode),
            .init(title: "Privacy Policy", iconName: "shield", type: .privacy)
        ]
    }

    func onAppear() {
        buildItem()
    }
}
