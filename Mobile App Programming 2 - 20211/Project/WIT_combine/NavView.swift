//
//  NavView.swift
//  teamProject_pre
//
//  Created by 이재준 on 2021/05/19.
//

import SwiftUI

struct NavView: View {
    var colWidth: CGFloat
    @Binding var x : CGFloat
    
    var body: some View {
        ZStack {
            HStack {
                Button(action: {
                    print("button is working")
                    withAnimation{
                        x = 0
                    }
                }) {
                    Image(systemName: "text.justify")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:30)
                        .foregroundColor(Color.black)
                }.padding(.leading, 10)
                Spacer()
            }
            Text("WIT")
                .font(.system(size : 30))
                .fontWeight(.bold)
                .foregroundColor(.black)
        }
        
        .padding()
        .background(Color.white)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x:0, y:5)
    }
}
