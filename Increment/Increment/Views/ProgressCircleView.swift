//
//  ProgressCircleView.swift
//  Increment
//
//  Created by Park Gyurim on 2021/09/07.
//

import SwiftUI

struct ProgressCircleView : View {
    let viewModel : ProgressCircleViewModel
    @State private var percentage : CGFloat = 0 // for animation
    
    var body : some View {
        ZStack {
            Circle()
                .stroke(style : .init(lineWidth: 10, lineCap: .round, lineJoin: .round))
                .fill(Color.circleOutline)
            Circle()
                .trim(from: 0, to: percentage)
                .stroke(style : .init(lineWidth: 10, lineCap: .round, lineJoin: .round))
                .fill(Color.circleTrack)
                .rotationEffect(Angle.init(degrees: -90))
            
            VStack {
                if viewModel.shouldShowTitle {
                    Text(viewModel.title)
                }
                Text(viewModel.message)
            }.padding(25)
            .font(Font.caption.weight(.semibold))
        }.onAppear{
            withAnimation(.spring(response : 2)) {
                percentage = CGFloat(viewModel.percentageComplete)
            }
        }
    }
}
