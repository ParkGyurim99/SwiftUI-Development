//
//  ChallengeService.swift
//  Increment
//
//  Created by Park Gyurim on 2021/08/30.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift // will allow us to user our codable Challenge

protocol ChallengeServiceProtocol {
    func create(_ challenge : Challenge) -> AnyPublisher<Void, IncrementError>
    func observeChallenges(userId : UserId) -> AnyPublisher<[Challenge], IncrementError>
}

final class ChallengeService : ChallengeServiceProtocol {
    private let db = Firestore.firestore()
    
    func create(_ challenge: Challenge) -> AnyPublisher<Void, IncrementError> {
        return Future<Void, IncrementError> { promise in
            do {
                _ = try self.db.collection("challenges").addDocument(from: challenge) { error in
                    if let error = error {
                        promise(.failure(.default(description : error.localizedDescription)))
                    } else {
                        promise(.success(()))
                    }
                }
                promise(.success(()))
            } catch {
                promise(.failure(.default()))
            }
        }.eraseToAnyPublisher()
    }
    
    func observeChallenges(userId: UserId) -> AnyPublisher<[Challenge], IncrementError> {
        let query = db.collection("challenges").whereField("userId", isEqualTo: userId)
        
        return Publishers.querySnapshotPublisher(query : query)
            .flatMap { snapshot -> AnyPublisher<[Challenge], IncrementError> in
                do {
                    let challenges = try snapshot.documents.compactMap { try $0.data(as : Challenge.self) }
                    return Just(challenges).setFailureType(to: IncrementError.self).eraseToAnyPublisher()
                } catch {
                    return Fail(error : .default(description : "Parsing error"))
                        .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
}
