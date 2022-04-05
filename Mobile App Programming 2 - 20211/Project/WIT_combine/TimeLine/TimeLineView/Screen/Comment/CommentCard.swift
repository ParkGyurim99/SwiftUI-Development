//
//  CommentCard.swift
//  WIT_combine
//
//  Created by Park Gyurim on 2021/06/18.
//

import SwiftUI
import SDWebImageSwiftUI

struct CommentCard: View {
    
    var comment: CommentModel
    
    var body: some View {
        HStack {
            WebImage(url: URL(string: comment.profile)!)
                .resizable()
                .aspectRatio(contentMode:.fill)
                .clipShape(Circle())
                .frame(width:35,height:35,alignment:.center)
                .overlay(
                    Circle()
                        .stroke(Color.blue, lineWidth: 2)
                )
            VStack(spacing : 10) {
                HStack {
                    Text(comment.username).font(.system(size : 15)).bold()
                    Text(comment.comment).font(.system(size : 13))
                    Spacer()
                }
                HStack {
                    Text((Date(timeIntervalSince1970: comment.date)).timeAgo())
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("Reply")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Spacer()
                }
            }
            Spacer()
        }.padding(5)
        .padding(.horizontal, 10)
    }
}
