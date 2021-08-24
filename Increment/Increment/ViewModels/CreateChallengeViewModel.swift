//
//  CreateChallengeViewModel.swift
//  Increment
//
//  Created by Park Gyurim on 2021/08/24.
//

import SwiftUI

final class CreateChallengeViewModel : ObservableObject {
    @Published var dropdowns : [ChallengePartViewModel] = [
        .init(type : .excercise),
        .init(type : .startAmount),
        .init(type : .increase),
        .init(type : .length)
    ]
}

extension CreateChallengeViewModel {
    // Better to think this is for each element of dropdowns array above
    struct ChallengePartViewModel : DropdownItemProtocol {
        var options: [DropdownOption]
        var headerTitle: String { type.rawValue }
        var dropdownTitle: String { options.first(where : {$0.isSelected})?.formatted ?? "" }
        var isSelected: Bool = false
        
        private let type : ChallengePartType
        
        init(type : ChallengePartType) {
            switch type {
            case .excercise :
                self.options = ExcerciseOption.allCases.map {$0.toDropdownOption}
            case .startAmount :
                self.options = StartOption.allCases.map {$0.toDropdownOption}
            case .increase :
                self.options = IncreaseOption.allCases.map {$0.toDropdownOption}
            case .length :
                self.options = LengthOption.allCases.map {$0.toDropdownOption}
            }
            self.type = type
            
        }
        
        enum ChallengePartType : String, CaseIterable {
            case excercise = "Excercise"
            case startAmount = "Starting Amount"
            case increase = "Daily Increase"
            case length = "Challenge Length"
        }
        
        enum ExcerciseOption : String, CaseIterable, DropdownOptionProtocol {
            case pullups
            case pushups
            case situps
            
            var toDropdownOption: DropdownOption {
                .init(
                    type: .text(rawValue),
                    formatted: rawValue.capitalized,
                    isSelected: self == .pullups
                )
            }
        }
        
        enum StartOption : Int, CaseIterable, DropdownOptionProtocol {
            case one = 1, two, three, four, five
            
            var toDropdownOption: DropdownOption {
                .init(
                    type: .number(rawValue),
                    formatted: "\(rawValue)",
                    isSelected: self == .one
                )
            }
        }
        
        enum IncreaseOption : Int, CaseIterable, DropdownOptionProtocol {
            case one = 1, two, three, four, five
            
            var toDropdownOption: DropdownOption {
                .init(
                    type: .number(rawValue),
                    formatted: "+\(rawValue)",
                    isSelected: self == .one
                )
            }
        }
        
        enum LengthOption : Int, CaseIterable, DropdownOptionProtocol {
            case seven = 7, fourteen = 14, twentyOne = 21, twentyEight = 28
            
            var toDropdownOption: DropdownOption {
                .init(
                    type: .number(rawValue),
                    formatted: "\(rawValue) days",
                    isSelected: self == .seven
                )
            }
        }
    }
}
