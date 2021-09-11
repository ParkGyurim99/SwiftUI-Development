//
//  LogItemViewModel.swift
//  Increment
//
//  Created by Park Gyurim on 2021/09/12.
//

import Foundation

final class LogItemViewModel : Identifiable {
    private let challenge : Challenge
    

    var id : String { challenge.id! }
    
    init(_ challenge : Challenge) {
        self.challenge = challenge
    }
    
    var title : String { challenge.exercise }
    var startDate : String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd."
        return dateFormatter.string(from: challenge.startDate)
    }
    var subTitle : String { "Since " + startDate }
}
