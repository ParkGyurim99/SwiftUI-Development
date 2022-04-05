//
//  LogViewModel.swift
//  Increment
//
//  Created by Park Gyurim on 2021/09/12.
//

import Foundation
import Combine

final class LogViewModel : ObservableObject {
    let title = "Challenges Log"
    private let userService : UserServiceProtocol
    private let challengeService : ChallengeServiceProtocol
    private var cancellables : [AnyCancellable] = []
    
    @Published private(set) var listViewModels : [LogItemViewModel] = []
    
    init(
        userService : UserServiceProtocol = UserService(),
        challengeService : ChallengeServiceProtocol = ChallengeService()
    ) {
        self.userService = userService
        self.challengeService = challengeService
    }
    
    private func observeChallenges() {
        userService.currentUserPublisher()
            .compactMap { $0?.uid }
            .flatMap { [weak self] userId -> AnyPublisher<[Challenge], IncrementError> in
                guard let self = self else { return Fail(error : .default()).eraseToAnyPublisher() }
                return self.challengeService.observeChallenges(userId: userId)
            }.sink { completion in
                switch completion {
                case let .failure(error) :
                    print(error)
                case .finished :
                    print("finished")
                }
            } receiveValue: { [weak self] challenges in
                self?.listViewModels = challenges.map { challenge in
                    .init(challenge)
                }
            }.store(in : &cancellables)
    }
    
    func listChallenge() {
        observeChallenges()
    }
}
