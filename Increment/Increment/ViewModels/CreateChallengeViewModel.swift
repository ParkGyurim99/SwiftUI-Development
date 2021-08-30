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
//    @Published var dropdowns : [ChallengePartViewModel] = [
//        .init(type : .excercise),
//        .init(type : .startAmount),
//        .init(type : .increase),
//        .init(type : .length)
//    ]
    
    @Published var exerciseDropdown = ChallengePartViewModel(type : .exercise)
    @Published var startAmountDropdown = ChallengePartViewModel(type : .startAmount)
    @Published var increaseDropdown = ChallengePartViewModel(type : .increase)
    @Published var lengthDropdown = ChallengePartViewModel(type : .length)
    
    private let userService : UserServiceProtocol
    private let challengeService : ChallengeServiceProtocol
    private var cancellables : [AnyCancellable] = []
    
    enum Action {
        case createChallenge
    }
    
    init(userService : UserServiceProtocol = UserService(), challengeService : ChallengeServiceProtocol = ChallengeService()) {
        self.userService = userService
        self.challengeService = challengeService
    }
    
    func send(action : Action) {
        switch action {
        case .createChallenge :
            currentUserId().flatMap { userId -> AnyPublisher<Void, Error> in
                return self.createChallenge(userId: userId)
            }
            .sink { completion in
                switch completion {
                case let .failure(error) :
                    print(error.localizedDescription)
                case .finished :
                    print("finished")
                }
            } receiveValue: { _ in
                print("success")
            }.store(in: &cancellables)
        }
    }
    
    private func createChallenge(userId : UserId) -> AnyPublisher<Void, Error> {
        guard let exercise = exerciseDropdown.text,
              let startAmount = startAmountDropdown.number,
              let increase = increaseDropdown.number,
              let length = lengthDropdown.number else {
            return Fail(error: NSError()).eraseToAnyPublisher()
        }
        
        let challenge = Challenge(
            exercise: exercise,
            startAmount: startAmount,
            increae: increase,
            length: length,
            userId: userId,
            startDate: Date()
        )
        
        return challengeService.create(challenge).eraseToAnyPublisher()
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
        var selectedOption: DropdownOption
        
        var options: [DropdownOption]
        var headerTitle: String { type.rawValue }
        var dropdownTitle: String { selectedOption.formatted }
        var isSelected: Bool = false
        
        private let type : ChallengePartType
        
        init(type : ChallengePartType) {
            switch type {
            case .exercise :
                self.options = ExerciseOption.allCases.map {$0.toDropdownOption}
            case .startAmount :
                self.options = StartOption.allCases.map {$0.toDropdownOption}
            case .increase :
                self.options = IncreaseOption.allCases.map {$0.toDropdownOption}
            case .length :
                self.options = LengthOption.allCases.map {$0.toDropdownOption}
            }
            
            self.type = type
            self.selectedOption = options.first!
        }
        
        enum ChallengePartType : String, CaseIterable {
            case exercise = "Excercise"
            case startAmount = "Starting Amount"
            case increase = "Daily Increase"
            case length = "Challenge Length"
        }
        
        enum ExerciseOption : String, CaseIterable, DropdownOptionProtocol {
            case pullups
            case pushups
            case situps
            
            var toDropdownOption: DropdownOption {
                .init(type: .text(rawValue),
                    formatted: rawValue.capitalized
                )
            }
        }
        
        enum StartOption : Int, CaseIterable, DropdownOptionProtocol {
            case one = 1, two, three, four, five
            
            var toDropdownOption: DropdownOption {
                .init(type: .number(rawValue),
                    formatted: "\(rawValue)"
                )
            }
        }
        
        enum IncreaseOption : Int, CaseIterable, DropdownOptionProtocol {
            case one = 1, two, three, four, five
            
            var toDropdownOption: DropdownOption {
                .init(
                    type: .number(rawValue),
                    formatted: "+\(rawValue)"
                )
            }
        }
        
        enum LengthOption : Int, CaseIterable, DropdownOptionProtocol {
            case seven = 7, fourteen = 14, twentyOne = 21, twentyEight = 28
            
            var toDropdownOption: DropdownOption {
                .init(
                    type: .number(rawValue),
                    formatted: "\(rawValue) days"
                )
            }
        }
    }
}

extension CreateChallengeViewModel.ChallengePartViewModel {
    
    // shortcut to text and number
    var text : String? {
        if case let .text(text) = selectedOption.type {
            return text
        }
        return nil
    }
    
    var number : Int? {
        if case let .number(number) = selectedOption.type {
            return number
        }
        return nil
    }
}
