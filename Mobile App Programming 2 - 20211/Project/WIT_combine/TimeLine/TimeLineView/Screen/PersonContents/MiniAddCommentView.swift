//
//  miniAddCommentView.swift
//  WIT
//
//  Created by LEESEUNGMIN on 2021/05/21.
//

import SwiftUI

struct MiniAddCommentView: View {

    @ObservedObject var commentService = CommentService()
    @State private var text: String = ""
    
    init(post: PostModel?, postId: String?){
        if post != nil {
            commentService.post = post
        } else {
            handleInput(postId: postId!)
        }
    }
    
    func handleInput(postId: String){
        PostService.loadPost(postId: postId){
            (post) in
            self.commentService.post = post
        }
    }
    func sendComment(){
        if !text.isEmpty {
            commentService.addComment(comment: text){
                self.text = ""
            }
        }
    }
    
    
    let placeholder = " Add a comment"
    
    func emojiButton(_ emoji: String) -> Button<Text> {
        Button{
            self.text += emoji
        } label: {
            Text(emoji)
        }
    }
    
    var body: some View {
//        ZStack{
        Section {
            HStack(spacing:10){
                TextField(placeholder, text: $text)
                    .frame(width : UIScreen.main.bounds.width * 0.7, height:40)
                    .overlay(RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray,lineWidth: 0.5)
                    )
                emojiButton("❤️")
                Button(action:sendComment){
                    Image(systemName: "plus.circle")
                        .frame(width: 20)
                        .foregroundColor(.black)
                }
//            }
//            .padding(.leading,50)
            }
        }//.background(Color.secondary)
    }
}
