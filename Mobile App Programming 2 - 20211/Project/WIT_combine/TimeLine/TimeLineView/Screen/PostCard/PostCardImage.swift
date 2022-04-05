//
//  PostCardImage.swift
//  WIT_combine
//
//  Created by LEESEUNGMIN on 2021/06/17.
//

import SwiftUI
import SDWebImageSwiftUI


struct PostCardImage: View {
    var post: PostModel
    
    var body: some View {
        LazyVStack(alignment:.leading){
            HStack {
                WebImage(url:URL(string: post.profile)!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:35)
                    .padding(.vertical, 3)
                    .clipShape(Circle())
//                    .overlay(Circle()
//                    .stroke(Color.blue,lineWidth: 1))
                
                VStack(alignment:.leading){
                    Text(post.username)
                        .font(.system(size:15))
                        .fontWeight(.bold)
//                        .padding(.bottom,0.1)
                        
                    Text((Date(timeIntervalSince1970: post.date)).timeAgo()+" ago")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }.padding(.leading,10)
                Spacer()
                
            }.padding(.leading)
            .padding(.top,16)
            
            WebImage(url:URL(string: post.mediaurl)!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width:UIScreen.main.bounds.size.width, height:400,alignment:.center)
                .clipped()
            PostCard(post: post)

        }
    }
}

