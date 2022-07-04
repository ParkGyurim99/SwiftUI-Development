//
//  Data.swift
//  SwiftChartsPractice
//
//  Created by Park Gyurim on 2022/07/04.
//

import Foundation

func date(_ year: Int, _ month: Int, _ day: Int) -> Date {
    Calendar.current.date(from: DateComponents(year: year, month: month, day: day)) ?? Date()
}

let seriesData : [Series] = [
    .init(city : City.Cupertino.rawValue, sales : cupertinoData),
    .init(city : City.SanFrancisco.rawValue, sales : sfData)
]

let cupertinoData : [SalesSummary] = [
    .init(weekday: date(2022, 5, 2), sales: 54),
    .init(weekday: date(2022, 5, 3), sales: 42),
    .init(weekday: date(2022, 5, 4), sales: 88),
    .init(weekday: date(2022, 5, 5), sales: 49),
    .init(weekday: date(2022, 5, 6), sales: 42),
    .init(weekday: date(2022, 5, 7), sales: 125),
    .init(weekday: date(2022, 5, 8), sales: 67)
]

let sfData : [SalesSummary] = [
    .init(weekday: date(2022, 5, 2), sales: 81),
    .init(weekday: date(2022, 5, 3), sales: 90),
    .init(weekday: date(2022, 5, 4), sales: 52),
    .init(weekday: date(2022, 5, 5), sales: 72),
    .init(weekday: date(2022, 5, 6), sales: 84),
    .init(weekday: date(2022, 5, 7), sales: 84),
    .init(weekday: date(2022, 5, 8), sales: 137)
]
