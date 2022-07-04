//
//  ContentView.swift
//  SwiftChartsPractice
//
//  Created by Park Gyurim on 2022/07/03.
//

import SwiftUI
import Charts

struct ContentView: View {
    var body: some View {
        VStack {
            Chart(seriesData) { series in
                ForEach(series.sales) { sale in
                    PointMark(x: .value("Day", sale.weekday, unit: .day),
                             y: .value("Sales", sale.sales))
                    .foregroundStyle(by: .value("City", series.city))
                    .symbol(by: .value("City", series.city))
                }
            }
        }.padding()
    }
    
//    var data : [SalesSummary] {
//        switch city {
//            case .Cupertino: return cupertinoData
//            case .SanFrancisco: return sfData
//        }
//    }
//    var body: some View {
//        VStack {
//            Picker("City", selection : $city.animation(.easeInOut)) {
//                Text(City.Cupertino.rawValue).tag(City.Cupertino)
//                Text(City.SanFrancisco.rawValue).tag(City.SanFrancisco)
//            }.pickerStyle(.segmented)
//
//            Chart(data) { sale in
//                BarMark(x: .value("Day", sale.weekday, unit: .day),
//                        y: .value("Sales", sale.sales))
//            }
//        }.padding()
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
