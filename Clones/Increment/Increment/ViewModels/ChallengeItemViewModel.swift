//
//  ChallengeItemViewModel.swift
//  Increment
//
//  Created by Park Gyurim on 2021/09/02.
//

import Foundation

struct ChallengeItemViewModel : Identifiable {
    private let challenge : Challenge
    
    var id : String {
        challenge.id!
    }
    
    private let onDelete : (String) -> Void
    private let onToggleComplete : (String, [Activity]) -> Void
    
    init(
        _ challenge : Challenge,
        onDelete : @escaping (String) -> Void,
        onToggleComplete : @escaping (String, [Activity]) -> Void
    ) {
        self.challenge = challenge
        self.onDelete = onDelete
        self.onToggleComplete = onToggleComplete
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
    
    var isComplete : Bool {
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
    
    let todayTitle = "Today"
    var todayRepTitle : String {
        let repNumber = challenge.startAmount + (daysFromStart * challenge.increase)
        let execercise : String

        if repNumber == 1 {
            var challengeExecercise = challenge.exercise
            challengeExecercise.removeLast()
            execercise = challengeExecercise
        } else {
            execercise = challenge.exercise
        }
        
        return isComplete ? "Completed" : "\(repNumber) " + execercise
    }
    
    var shouldShowTodayView : Bool { !isComplete }
    
    var isDayComplete : Bool {
        let today = Calendar.current.startOfDay(for: Date())
        
        return challenge.activities.first(where: { $0.date == today })?.isComplete == true
    }
    
    func send(action : Action) {
        guard let id = challenge.id else { return }
        //challenge.activities[daysFromStart - 1].isComplete = true
        switch action {
        case .delete :
            onDelete(id)
        case .toggleComplete :
            let today = Calendar.current.startOfDay(for: Date())
            let activities = challenge.activities.map { activity -> Activity in
                if today == activity.date {
                    return .init(date : today, isComplete : !activity.isComplete)
                } else {
                    return activity
                }
            }
            onToggleComplete(id, activities)
        }
    }
}

extension ChallengeItemViewModel {
    enum Action {
        case delete
        case toggleComplete
    }
}
