//
//  ContentView.swift
//  UsedWritingTest
//
//  Created by Park Gyurim on 2022/03/07.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            NavigationLink(destination : UsedWritingView()) {
                Image(systemName : "plus")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.yellow)
                    .clipShape(Circle())
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
