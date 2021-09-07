//
//  ProgressCircleViewModel.swift
//  Increment
//
//  Created by Park Gyurim on 2021/09/08.
//

import Foundation

struct ProgressCircleViewModel {
    let title : String
    let message : String
    let percentageComplete : Double
    var shouldShowTitle : Bool { return percentageComplete <= 1 }
}
