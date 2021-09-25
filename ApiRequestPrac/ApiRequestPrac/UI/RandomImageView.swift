//
//  RandomImageView.swift
//  ApiRequestPrac
//
//  Created by Park Gyurim on 2021/09/25.
//

import SwiftUI
import URLImage

struct RandomImageView : View {
    var imageURL : URL
    
    var body : some View {
        URLImage(imageURL) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        .frame(width: 50, height: 60)
        .clipShape(Circle())
        .overlay(
            Circle()
                .stroke(Color.yellow, lineWidth: 2)
        )
    }
}

struct RandomImageView_Previews: PreviewProvider {
    static var previews: some View {
        let url : URL = URL(string : "https://randomuser.me/api/portraits/men/11.jpg")!
        
        RandomImageView(imageURL: url)
    }
}
