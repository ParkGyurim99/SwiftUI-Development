//
//  FilterFlights.swift
//  Enroute
//
//  Created by Park Gyurim on 2021/05/28.
//  Copyright © 2021 Stanford University. All rights reserved.
//

import SwiftUI

struct FilterFlights: View {
    @ObservedObject var allAirports = Airports.all // view model
    @ObservedObject var allAirlines = Airlines.all
    
    @Binding var flightSearch : FlightSearch
    @Binding var isPresented : Bool
    
    @State private var draft : FlightSearch
    
    init(flightSearch : Binding<FlightSearch>, isPresented : Binding<Bool>) {
        _flightSearch = flightSearch
        _isPresented = isPresented
        _draft = State(wrappedValue: flightSearch.wrappedValue)
        // lecture 09 의 Published wrapper 페이지랑 같이 보기
    }
    
    var body: some View {
        NavigationView {
            Form {
                //Text("Filter flights to \(draft.destination)")
                Picker("Desination", selection: $draft.destination) { // selection: picker에서 선택한 항목을 반영하고 싶은 변수
                    ForEach(allAirports.codes, id : \.self) { airport in
                        Text(self.allAirports[airport]?.friendlyName ?? airport).tag(airport) // optional chaining
                        // tag 의미 : selection과 연결
                        // .. 지금은 Text 뷰 하나만 있지만, Picker안에 다른 뷰들이 있을 수도 있다.
                        // 그떄 picker에서 선택된 값을 selection에 할당하기 위해 tag 써야함
                    }
                }
                Picker("Origin", selection: $draft.origin) { // origin is Optional String type
                    Text("Any").tag(String?.none) // String?.none : String nil representation
                    ForEach(allAirports.codes, id : \.self) { (airport : String?) in
                        Text(self.allAirports[airport]?.friendlyName ?? airport ?? "Any").tag(airport)
                    }
                }//.pickerStyle(MenuPickerStyle())
                
                Picker("Airline", selection: $draft.airline) { // Airline is Optional String type
                    Text("Any").tag(String?.none) // String?.none : String nil representation
                    ForEach(allAirlines.codes, id : \.self) { (airline : String?) in
                        Text(self.allAirlines[airline]?.friendlyName ?? airline ?? "Any").tag(airline)
                    }
                }
                Toggle(isOn: $draft.inTheAir) {
                    Text("Enroute Only")
                }
            }.navigationBarTitle("Filter Flight")
            .navigationBarItems(leading: cancel, trailing: done)
        }
    }
    var cancel : some View {
        Button("cancel") {
            self.isPresented = false
        }
    }
    var done : some View {
        Button("done") {
            // make the catual change
            self.flightSearch = self.draft
            self.isPresented = false
        }
    }
}
