//
//  ChallengeListView.swift
//  Increment
//
//  Created by Park Gyurim on 2021/08/31.
//

import SwiftUI

struct ChallengeListView : View {
    @StateObject private var viewModel : ChallengeListViewModel = ChallengeListViewModel()
    
    var body : some View {
        ScrollView {
            VStack {
                LazyVGrid(columns: [.init(.flexible()), .init(.flexible())]) {
                    ForEach(viewModel.itemViewModels, id : \.self) { viewModel in
                        challengeItemView(viewModel : viewModel)
                    }
                }
                Spacer()
            }
        }.navigationTitle(viewModel.title)
    }
}

struct challengeItemView : View {
    private let viewModel : ChallengeItemViewModel
    
    init(viewModel : ChallengeItemViewModel) {
        self.viewModel = viewModel
    }
    
    var body : some View {
        HStack {
            Spacer()
            VStack {
                Text(viewModel.title)
                    .font(.system(size: 24, weight : .bold))
                Text(viewModel.statusText)
                Text(viewModel.dailyIncreaseText)
            }.padding()
            Spacer()
        }
        .background(
            Rectangle()
                .fill(Color.darkPrimaryButton)
                .cornerRadius(10)
        )
        .padding()
    }
}
