//
//  RandomUserRowView.swift
//  ApiRequestPrac
//
//  Created by Park Gyurim on 2021/09/25.
//

import SwiftUI

struct RandomUserRowView : View {
    var randomUser : RandomUser
    
    // 외부 파라미터 이름 없애려고 만듦
    init(_ randomUser : RandomUser) {
        self.randomUser = randomUser
    }
    
    var body : some View {
        HStack {
            RandomImageView(imageURL: randomUser.profileImageUrl)
            Text(randomUser.description)
                .fontWeight(.heavy)
                .font(.system(size : 25))
                .lineLimit(2) // maximum text line
                .minimumScaleFactor(0.5) // if text is too long, ...
        }.padding(.vertical)
    }
}

struct RandomUserRowView_Previews: PreviewProvider {
    static var previews: some View {
        RandomUserRowView(RandomUser.getDummy())
    }
}
