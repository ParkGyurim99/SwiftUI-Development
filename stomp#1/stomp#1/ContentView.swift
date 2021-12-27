//
//  ContentView.swift
//  stomp#1
//
//  Created by Park Gyurim on 2021/12/27.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        Button("Connect") {
            StompManager.shared.registerSockect()
        }
        Button("Disconnect") {
            StompManager.shared.disconnect()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
