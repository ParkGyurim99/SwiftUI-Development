//
//  myHstack.swift
//  app005
//
//  Created by 박규림 on 2020/12/20.
//

import SwiftUI

struct myHstack : View {
    var body : some View {
        HStack(alignment: .center) {
//            Divider()
//            Rectangle()
//                .frame(width: 100)
//                .foregroundColor(Color.red)
            
//            Rectangle()
//                .frame(width: 100, height: 100)
//                .foregroundColor(Color.red)
            Image(systemName: "flame.fill")
                .font(.system(size : 70))
            
            Rectangle()
                .frame(width: 100, height: 100)
                .foregroundColor(Color.yellow)
            Rectangle()
                .frame(width: 100, height: 100)
                .foregroundColor(Color.blue)
        }
        .padding()
        .background(Color.green)
    }
}
