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
    @Published var showingCreateModal : Bool = false
    
    enum Action {
        case retry
        case create
        case timeChange
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
            showingCreateModal = true
        case .timeChange :
            cancellables.removeAll()
            observeChallenges()
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
                self.showingCreateModal = false
                print(challenges)
                self.itemViewModels = challenges.map{ challenge in
                    .init(
                        challenge,
                        onDelete : { [weak self] id in
                            // onDelete parameter를 trailing closer로 받음. callback function 받음
                            self?.deleteChallenge(id)
                        },
                        onToggleComplete: { [weak self] id, activities in
                            self?.updateChallenge(id : id, activities : activities)
                        }
                    )
                }
            }.store(in : &cancellables)
    }
    
    private func deleteChallenge(_ challengeId : String) {
        challengeService.delete(challengeId).sink { completion in
            switch completion {
            case let .failure(error) :
                print(error.localizedDescription)
            case .finished : break
            }
        } receiveValue: { _ in }
        .store(in : &cancellables)
    }
    
    private func updateChallenge(id : String, activities : [Activity]) {
        challengeService.updateChallenge(id, activities: activities).sink { completion in
            switch completion {
            case let .failure(error) :
                print(error.localizedDescription)
            case .finished : break
            }
        } receiveValue: { _ in }
        .store(in : &cancellables)
    }
}
