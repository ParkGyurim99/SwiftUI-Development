//
//  main.swift
//  DatePrac
//
//  Created by Park Gyurim on 2022/05/20.
//

import Foundation

var now = Date()
var previousIssued = Date(timeInterval: TimeInterval(-1800), since: now)

print(now)
print(previousIssued)
print(now.timeIntervalSince(previousIssued))
