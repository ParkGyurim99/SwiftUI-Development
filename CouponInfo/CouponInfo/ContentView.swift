//
//  ContentView.swift
//  CouponInfo
//
//  Created by Park Gyurim on 2022/02/22.
//

import SwiftUI

struct ContentView: View {
    @State var showNavigationBar : Bool = true
    @State private var offset = CGFloat.zero
    
    var body: some View {
        NavigationView {
            ScrollView {
               VStack {
                   ForEach(0..<100) { i in
                       Text("Item (i)")
                           .padding()
                   }
               }.frame(maxWidth : .infinity)
               .background(
                    GeometryReader {
                       Color.clear
                            .preference(key: ScrollViewOffsetKey.self, value: -$0.frame(in: .named("scroll")).origin.y)
                   }
               )
               .onPreferenceChange(ScrollViewOffsetKey.self) {
                   if $0 > 295.4 { withAnimation { showNavigationBar = false } }
                   else { withAnimation { showNavigationBar = true } }
               }
           }.coordinateSpace(name: "scroll")
            .navigationTitle(Text("Store name"))
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(showNavigationBar)
        }
    }
}

struct ScrollViewOffsetKey: PreferenceKey {
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
