//
//  QuerySnapshotPublisher.swift
//  Increment
//
//  Created by Park Gyurim on 2021/08/31.
//
//  we can pass in any query that we want and firestore will listen for that query
//

import Combine
import Firebase

extension Publishers {
    struct querySnapshotPublisher : Publisher {
        // to conforming protocol
        typealias Output = QuerySnapshot
        typealias Failure = IncrementError
        
        private let query : Query
        
        init(query : Query) { self.query = query }
        
        func receive<S>(subscriber: S) where S : Subscriber, IncrementError == S.Failure, QuerySnapshot == S.Input {
            let querySnapshotSubscription = QuerySnapshotSubscription(subscriber: subscriber, query: query)
            subscriber.receive(subscription: querySnapshotSubscription)
        }
    }
    
    class QuerySnapshotSubscription<S : Subscriber> : Subscription where S.Input == QuerySnapshot, S.Failure == IncrementError {
        private var subscriber : S?
        private var listener : ListenerRegistration?
        
        init(subscriber : S, query : Query) {
            listener = query.addSnapshotListener { querySnapshot, error in
                if let error = error { //if it does't have error
                    subscriber.receive(completion: .failure(.default(description: error.localizedDescription)))
                } else if let querySnapshot = querySnapshot {
                    _ = subscriber.receive(querySnapshot)
                } else {
                    subscriber.receive(completion: .failure(.default()))
                }
            }
        }
        
        func request(_ demand: Subscribers.Demand) {}
        func cancel() {
            subscriber = nil
            listener = nil
        }
    }
}
