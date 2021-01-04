//
//  profileView.swift
//  app012
//
//  Created by 박규림 on 2021/01/04.
//

import SwiftUI

struct profileView : View {
    var body : some View {
        Rectangle()
            .foregroundColor(Color.init(#colorLiteral(red: 0.7945222259, green: 0.463537991, blue: 0.9666145444, alpha: 1)))
            .frame(width : 100, height: 100)
            .cornerRadius(15)
            .overlay(Text("Profile")
                        .font(.system(size: 20))
                        .fontWeight(.black)
                        .foregroundColor(.white)
            )
    }
}
