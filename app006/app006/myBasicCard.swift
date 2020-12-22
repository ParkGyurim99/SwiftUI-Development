//
//  myBasicCard.swift
//  app006
//
//  Created by 박규림 on 2020/12/23.
//

import SwiftUI

struct myBasicCard : View {
    var body : some View {
        HStack(spacing : 20) {
            Image(systemName : "character.book.closed.fill")
                .font(.system(size : 40))
                .foregroundColor(.white)

            VStack(alignment : .leading, spacing : 0) {
                Rectangle().frame(height : 0)
                Text("OPic Study")
                    .foregroundColor(.white)
                    .font(.system(size : 23))
                    .fontWeight(.black)
                Spacer()
                    .frame(height : 5)
                Text("~ 2021/02")
                    .foregroundColor(.white) //회색
            }
    
        }
        .padding(30)
        .background(Color.purple)
        .cornerRadius(20)
        
    }
}
