//
//  ChallengeListViewModel.swift
//  Increment
//
//  Created by Park Gyurim on 2021/08/31.
//

import Foundation
import Combine

final class ChallengeListViewModel : ObservableObject {
    private let userService : UserServiceProtocol
    private let challengeService : ChallengeServiceProtocol
    private var cancellables : [AnyCancellable] = []
    
    init(userService : UserServiceProtocol = UserService(), challengeService : ChallengeServiceProtocol = ChallengeService()) {
        self.userService = userService
        self.challengeService = challengeService
        observeChallenges()
    }
    
    private func observeChallenges() {
        // grab the current user id and pass it into a ChallengesService.observeChallenge
        userService.currentUser()
            .compactMap { $0?.uid }
            .flatMap { userId -> AnyPublisher<[Challenge], IncrementError> in
                return self.challengeService.observeChallenges(userId: userId)
            }.sink { completion in
                switch completion {
                case let .failure(error) :
                    print(error.localizedDescription)
                case .finished :
                    print("finished")
                }
            } receiveValue: { challenges in
                print(challenges)
            }.store(in : &cancellables)
    }
}
