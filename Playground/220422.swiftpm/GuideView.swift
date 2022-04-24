//
//  GuideView.swift
//  220422
//
//  Created by Park Gyurim on 2022/04/23.
//

import SwiftUI

struct GuideView : View {
    @Binding var isPresented : Bool
    
    var body : some View {
        VStack {
            HStack {
                Text(GuideTextSet.TitleText.rawValue)
                    .font(.system(.largeTitle, design: .monospaced))
                    .fontWeight(.bold)
                Spacer()
                Button {
                    isPresented.toggle()
                } label : {
                    Image(systemName: ImageNameSet.xmark.rawValue)
                        .imageScale(.large)
                }
            }.padding()
            Divider()
            VStack(spacing : 20) {
                Text(GuideTextSet.Case1_Title.rawValue)
                    .font(.system(.title, design: .monospaced))
                    .fontWeight(.bold)
                Text(GuideTextSet.Case1_Description1.rawValue)
                    .font(.system(.title2, design: .monospaced))
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                Text(GuideTextSet.Case1_Description2.rawValue)
                    .font(.system(.title3, design: .monospaced))
                    .fontWeight(.light)
                    .foregroundColor(.gray)
                Spacer()
                Text(GuideTextSet.Case2_Title.rawValue)
                    .font(.system(.title, design: .monospaced))
                    .fontWeight(.bold)
                Text(GuideTextSet.Case2_Description1.rawValue)
                    .font(.system(.title2, design: .monospaced))
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                Text(GuideTextSet.Case2_Description2.rawValue)
                    .font(.system(.title3, design: .monospaced))
                    .fontWeight(.light)
                    .foregroundColor(.gray)
                Spacer()
                Text(GuideTextSet.Case3.rawValue)
                    .font(.system(.title3, design: .monospaced))
                    .fontWeight(.bold)
                    .padding(8)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(10)
            }.padding(.vertical)
        }.padding()
    }
}
