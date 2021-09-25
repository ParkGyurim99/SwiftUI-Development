//
//  ContentView.swift
//  ApiRequestPrac
//
//  Created by Park Gyurim on 2021/09/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = RandomUserViewModel()
    
    var body: some View {
        List(viewModel.randomUsers) { user in
            RandomUserRowView(user)
        }
        
//        List(0...100, id : \.self) { index in
//            RandomUserRowView()
//        }
        //.listStyle(PlainListStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
