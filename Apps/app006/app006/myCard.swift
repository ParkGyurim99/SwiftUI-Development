//
//  myCard.swift
//  app006
//
//  Created by 박규림 on 2020/12/23.
//

import SwiftUI

struct myCard : View {
    var icon : String
    var title : String
    var subTitle : String
    var backgroundColor : Color
    
    var body : some View {
        HStack(spacing : 20) {
            Image(systemName : icon)
                .font(.system(size : 40))
                .foregroundColor(.white)

            VStack(alignment : .leading, spacing : 0) {
                Rectangle().frame(height : 0)
                Text(title)
                    .foregroundColor(.white)
                    .font(.system(size : 23))
                    .fontWeight(.black)
                Spacer()
                    .frame(height : 5)
                Text(subTitle)
                    .foregroundColor(.white)
            }
    
        }
        .padding(30)
        .background(backgroundColor)
        .cornerRadius(20)
        
    }
}

