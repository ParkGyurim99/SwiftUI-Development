//
//  ContentView.swift
//  ConvertStringToDatePrac
//
//  Created by Park Gyurim on 2021/10/12.
//

import SwiftUI

struct ContentView: View {
    let stringDate = "2021-10-12 22:06:05" // origin : "2021-10-12T22:06:05.660602"
    let ogStringDate = "2021-10-12T22:06:05.660602"
    let now = Date()
    let korNow = Date(timeIntervalSinceNow: 32400) // UTC + 9H

    func convertReturnedStringToCal(src : String) -> String {
        var str = src
        str.removeSubrange(str.index(str.endIndex, offsetBy: -7)..<str.endIndex)
        str.remove(at: str.index(str.startIndex, offsetBy: 10))
        str.insert(" ", at: str.index(str.startIndex, offsetBy: 10))
        return str
    }
    
    var body: some View {
        Button {
            print("Updated time : " + convertReturnedStringToCal(src: ogStringDate))
            //print(now)
            //print(korNow)
            //print(stringDate.toDate())
            let timetravel = korNow.timeIntervalSince(stringDate.toDate()!)
            let secondDiff = Int(timetravel)
            print("\(secondDiff)초전")
            let minuteDiff = Int(timetravel/60)
            print("\(minuteDiff)분전")
            let hourDiff = Int(timetravel/3600)
            print("\(hourDiff)시간전")
            let dayDiff = Int(timetravel/86400)
            print("\(dayDiff)일전")
        } label : {
            Text(stringDate)
                .padding()
        }
    }
}

extension String {
    func toDate() -> Date? { //"yyyy-MM-dd HH:mm:ss"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        if let date = dateFormatter.date(from: self) { return date }
        else { return nil }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
