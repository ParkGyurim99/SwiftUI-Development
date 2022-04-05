//
//  ContentView.swift
//  pullToRefreshTest
//
//  Created by Park Gyurim on 2022/01/21.
//

import SwiftUI
import SwiftUIRefresh
import SwiftUIPullToRefresh

struct ContentView: View {
    @State var isShowing : Bool = false
    @State private var now = Date()

    @State var text = ["Text1", "Text1", "Text1" ]
    var body: some View {
        RefreshableScrollView(onRefresh: { done in
            done()
        }) {
            VStack {
                ForEach(text, id : \.self) {
                    Text($0)
                }
            }.padding()
        }
     }
}
