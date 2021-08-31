//
//  AuthPublisher.swift
//  Increment
//
//  Created by Park Gyurim on 2021/08/31.
//

import Combine
import FirebaseAuth

extension Publishers {
    struct AuthPublisher : Publisher {
        typealias Output = User?
        typealias Failure = Never
        
        func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
            let authSubscription = AuthSubscription(subscriber : subscriber)
            subscriber.receive(subscription : authSubscription)
        }
    }
    
    class AuthSubscription<S : Subscriber> : Subscription where S.Input == User?, S.Failure == Never {
        private var subscriber : S?
        private var handler : FirebaseAuth.AuthStateDidChangeListenerHandle?
        
        init(subscriber : S) {
            self.subscriber = subscriber
            handler = Auth.auth().addStateDidChangeListener{ auth, user in
                _ = subscriber.receive(user)
            }
        }
        
        func request(_ demand: Subscribers.Demand) { }
        func cancel() {
            subscriber = nil
            handler = nil
        }
    }
}
