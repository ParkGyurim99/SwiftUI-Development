//
//  ChallengeListViewModel.swift
//  Increment
//
//  Created by Park Gyurim on 2021/08/31.
//

import Foundation
import Combine

final class ChallengeListViewModel : ObservableObject {
    let title = "Challenges"
    private let userService : UserServiceProtocol
    private let challengeService : ChallengeServiceProtocol
    private var cancellables : [AnyCancellable] = []
    @Published private(set) var itemViewModels : [ChallengeItemViewModel] = []
    @Published private(set) var error : IncrementError?
    @Published private(set) var isLoading : Bool = false
    @Published var showingCreateModel : Bool = false
    
    enum Action {
        case retry
        case create
    }
    
    init(userService : UserServiceProtocol = UserService(), challengeService : ChallengeServiceProtocol = ChallengeService()) {
        self.userService = userService
        self.challengeService = challengeService
        observeChallenges()
    }
    
    func send(action : Action) {
        switch action {
        case .retry :
            observeChallenges()
        case .create :
            showingCreateModel = true
        }
    }
    
    // check the challenges view
    private func observeChallenges() {
        // grab the current user id and pass it into a ChallengesService.observeChallenge
        isLoading = true
        
        userService.currentUserPublisher()
            .compactMap { $0?.uid }
            .flatMap { [weak self] userId -> AnyPublisher<[Challenge], IncrementError> in
                guard let self = self else { return Fail(error : .default()).eraseToAnyPublisher() }
                return self.challengeService.observeChallenges(userId: userId)
            }.sink { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                switch completion {
                case let .failure(error) :
                    self.error = error
                    print(error.localizedDescription)
                case .finished :
                    print("finished")
                }
            } receiveValue: { [weak self] challenges in
                guard let self = self else { return }
                self.isLoading = false
                self.error = nil
                self.showingCreateModel = false
                print(challenges)
                self.itemViewModels = challenges.map{ .init($0) }
            }.store(in : &cancellables)
    }
}
