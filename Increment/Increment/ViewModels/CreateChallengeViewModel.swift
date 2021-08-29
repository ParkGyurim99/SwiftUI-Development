//
//  CreateChallengeViewModel.swift
//  Increment
//
//  Created by Park Gyurim on 2021/08/24.
//

import SwiftUI
import Combine

typealias UserId = String

final class CreateChallengeViewModel : ObservableObject {
    @Published var dropdowns : [ChallengePartViewModel] = [
        .init(type : .excercise),
        .init(type : .startAmount),
        .init(type : .increase),
        .init(type : .length)
    ]
    
    private let userService : UserServiceProtocol
    private var cancellables : [AnyCancellable] = []
    
    enum Action {
        case selectOption(index : Int)
        case createChallenge
    }
    
    // computed property (get only)
    var selectedDropdownIndex : Int? {
        dropdowns.enumerated().first(where : { $0.element.isSelected })?.offset
    }
    
    var hasSelectedDropdown : Bool {
        //dropdowns.first(where : { $0.isSelected }) != nil
        selectedDropdownIndex != nil
    }
    
    var displayOptions : [DropdownOption] {
        guard let selectedDropdownIndex = selectedDropdownIndex else { return [] }
        
        return dropdowns[selectedDropdownIndex].options
    }
    
    init(userService : UserServiceProtocol = UserService()) {
        self.userService = userService
    }
    
    func send(action : Action) {
        switch action {
        case let . selectOption(index) :
            guard let selectedDropdownIndex = selectedDropdownIndex else { return }
            clearSelectedOption()
            dropdowns[selectedDropdownIndex].options[index].isSelected = true
            clearSelectedDropdown()
        case .createChallenge :
            currentUserId().sink { completion in
                switch completion {
                case let .failure(error) :
                    print(error.localizedDescription)
                case .finished :
                    print("completed")
                }
            } receiveValue: { userId in
                print("retrieved user id : \(userId)")
            }.store(in: &cancellables)
        }
    }
    
    func clearSelectedOption() {
        guard let selectedDropdownIndex = selectedDropdownIndex else { return }

        dropdowns[selectedDropdownIndex].options.indices.forEach { index in
            dropdowns[selectedDropdownIndex].options[index].isSelected = false
        }
    }
    
    func clearSelectedDropdown() {
        guard let selectedDropdownIndex = selectedDropdownIndex else { return }

        dropdowns[selectedDropdownIndex].isSelected = false
    }
    
    private func currentUserId() -> AnyPublisher<UserId, Error> {
        print("getting userId")
        //return Just("").setFailureType(to : Error.self).eraseToAnyPublisher()
        
        // convert this into another publisher that give us the user id
        return userService.currentUser().flatMap { user -> AnyPublisher<UserId, Error> in
            if let UserId = user?.uid {
                print("user is logged in...")
                return Just(UserId)
                    .setFailureType(to : Error.self)
                    .eraseToAnyPublisher()
            } else {
                print("user is being logged in anonymously...")
                return self.userService
                    .signInAnonymously()
                    .map { $0.uid }
                    .eraseToAnyPublisher()
            }
        }.eraseToAnyPublisher()
    }
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
