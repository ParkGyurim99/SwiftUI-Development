//
//  ContentView.swift
//  MoyaPrac
//
//  Created by Park Gyurim on 2022/06/16.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        Button("Get Prediction") { viewModel.getFloodingPrediction() }
            .buttonStyle(.borderedProminent)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
