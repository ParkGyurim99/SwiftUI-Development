//
//  SettingsItemViewModel.swift
//  Increment
//
//  Created by Park Gyurim on 2021/09/04.
//

import Foundation

extension SettingsViewModel {
    struct SettingsItemViewModel {
        let title : String
        let iconName : String
        let type : SettingsItemType
    }
    
    enum SettingsItemType {
        case account
        case mode
        case privacy
    }
}
