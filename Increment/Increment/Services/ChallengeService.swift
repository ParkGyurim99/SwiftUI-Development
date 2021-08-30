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
    func create(_ challenge : Challenge) -> AnyPublisher<Void, Error>
}

final class ChallengeService : ChallengeServiceProtocol {
    private let db = Firestore.firestore()
    
    func create(_ challenge: Challenge) -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { promise in
            do {
                _ = try self.db.collection("challenges").addDocument(from: challenge)
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
}
