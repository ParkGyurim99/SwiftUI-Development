//
//  LogView.swift
//  Increment
//
//  Created by Park Gyurim on 2021/09/12.
//

import SwiftUI

struct LogView : View {
    @StateObject private var viewModel = LogViewModel()
    
    var body : some View {
        List {
            ForEach(viewModel.listViewModels) { item in
                HStack {
                    Text(item.title)
                    Spacer()
                    Text(item.subTitle)
                }
            }
        }
        .navigationTitle(viewModel.title)
        .onAppear { viewModel.listChallenge() }
    }
}
