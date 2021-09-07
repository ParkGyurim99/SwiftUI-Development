//
//  ChallengeItemViewModel.swift
//  Increment
//
//  Created by Park Gyurim on 2021/09/02.
//

import Foundation

struct ChallengeItemViewModel : Hashable {
    private let challenge : Challenge
    
    init(_ challenge : Challenge) {
        self.challenge = challenge
    }
    
    var progressCircleViewModel : ProgressCircleViewModel {
        let dayNumber = daysFromStart + 1
        let message = isComplete ? "Done" : "\(dayNumber) of \(challenge.length)"
        
        return .init(title: "Day", message: message, percentageComplete: Double(dayNumber) / Double(challenge.length))
    }
    
    var title : String {
        challenge.exercise.capitalized
    }

    private var daysFromStart : Int {
        let startDate = Calendar.current.startOfDay(for: challenge.startDate)
        let toDate = Calendar.current.startOfDay(for: Date())
        guard let daysFromStart = Calendar.current.dateComponents([.day], from: startDate, to: toDate).day else {
            return 0
        }
        return abs(daysFromStart)
    }
    
    private var isComplete : Bool {
        return daysFromStart >= challenge.length
    }
    
    var statusText : String {
        //let dayNumber = daysFromStart + 1
        guard !isComplete else { return "Done" } // if it's not completed, continue else reutnr done!
        return "Day \(daysFromStart + 1) of \(challenge.length)"
    }
    
    var dailyIncreaseText : String {
        return "+\(challenge.increase) daily"
    }
}