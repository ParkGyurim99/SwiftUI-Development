//
//  LandingView.swift
//  CouponInfo
//
//  Created by Park Gyurim on 2022/02/22.
//

import SwiftUI

struct LandingView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: ContentView()) {
                    Text("Link")
                }
            }.navigationTitle("LandingView")
        }
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
