//
//  ContentView.swift
//  BridgeAPITest
//
//  Created by Park Gyurim on 2021/09/28.
//

import SwiftUI

struct ContentView: View {
    @StateObject var ViewModel = viewModel()
    
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
