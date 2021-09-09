//
//  ChallengeItmeView.swift
//  Increment
//
//  Created by Park Gyurim on 2021/09/09.
//

import SwiftUI

struct ChallengeItemView : View {
    private let viewModel : ChallengeItemViewModel
        
    init(viewModel : ChallengeItemViewModel) {
        self.viewModel = viewModel
    }
    
    var titleRow : some View {
        HStack {
            Text(viewModel.title)
                .font(.system(size: 24, weight : .bold))
            Spacer()
            Image(systemName : "trash")
                .onTapGesture {
                    viewModel.tappedDelete()
                }
        }
    }
    
    var dailyIncreaseRow : some View {
        HStack {
            Text(viewModel.dailyIncreaseText)
                .font(.system(size: 24, weight : .bold))
            Spacer()
        }
    }
    
    var body : some View {
        HStack {
            Spacer()
            VStack {
                titleRow
                ProgressCircleView(viewModel: viewModel.progressCircleViewModel).padding(.vertical, 25)
                dailyIncreaseRow
            }.padding(.vertical, 10)
            Spacer()
        }
        .background(
            Rectangle()
                .fill(Color.primaryButton)
                .cornerRadius(10)
        )
    }
}
