//
//  UserServices.swift
//  Increment
//
//  Created by Park Gyurim on 2021/08/29.
//

import Combine
import FirebaseAuth

protocol UserServiceProtocol {
    // func that publisher to get the current user, look at firebase and return current user
    func currentUser() -> AnyPublisher<User?, Never>
    
    // sign in the user anonymously
    func signInAnonymously() -> AnyPublisher<User, IncrementError>
    func observeAuthChanges() -> AnyPublisher<User?, Never>
}

final class UserService : UserServiceProtocol {
    func currentUser() -> AnyPublisher<User?, Never> {
        Just(Auth.auth().currentUser).eraseToAnyPublisher() // to type erase it to AnyPublisher
    }
    
    func signInAnonymously() -> AnyPublisher<User, IncrementError> {
        return Future<User, IncrementError> { promise in
            Auth.auth().signInAnonymously { result, error in
                // if we have an error?
                if let error = error {
                    return promise(.failure(.auth(description: error.localizedDescription)))
                } else if let user = result?.user {
                    return promise(.success(user))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func observeAuthChanges() -> AnyPublisher<User?, Never> {
        Publishers.AuthPublisher().eraseToAnyPublisher()
    }
}
