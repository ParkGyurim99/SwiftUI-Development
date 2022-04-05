//
//  String+Extension.swift
//  SettingsTest
//
//  Created by Park Gyurim on 2022/03/13.
//

import Foundation
extension String {
    func containsNumbers() -> Bool {
        let numberRegEx  = ".*[0-9]+.*"
        let testCase     = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        return testCase.evaluate(with: self)
    }
    
    func containsCapitals() -> Bool {
        let stringRegEx  = ".*[A-Z]+.*"
        let testCase     = NSPredicate(format:"SELF MATCHES %@", stringRegEx)
        return testCase.evaluate(with: self)
    }
}
