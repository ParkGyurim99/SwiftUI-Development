//
//  SwiftUIView.swift
//  WIT_combine
//
//  Created by LEESEUNGMIN on 2021/06/17.
//

import SwiftUI

struct CommentView: View {
    @StateObject var commentService = CommentService()
    
    var post: PostModel?
    var postId: String?
    var body: some View {
        VStack{
            Spacer().frame(height : 10)
            ScrollView{
                if !commentService.comments.isEmpty {
                    ForEach(commentService.comments){
                        (comment) in
                        CommentCard(comment: comment)
                    }
                }
            }
            MiniAddCommentView(post: self.post, postId: self.postId)
                .padding(20)
                .border(width: 1, edges: [.top], color: .secondary)
        }
        .navigationBarTitle("Comments", displayMode: .inline)
        .onAppear{
            self.commentService.postId = self.post == nil ? self.postId : self.post?.postId
            
            self.commentService.loadComment()
        }
        .onDisappear{
            if self.commentService.listener != nil {
                self.commentService.listener.remove()
            }
        }
    }
}


extension View {
    func border(width: CGFloat, edges: [Edge], color: Color) -> some View {
        overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
    }
}
struct EdgeBorder: Shape {

    var width: CGFloat
    var edges: [Edge]

    func path(in rect: CGRect) -> Path {
        var path = Path()
        for edge in edges {
            var x: CGFloat {
                switch edge {
                case .top, .bottom, .leading: return rect.minX
                case .trailing: return rect.maxX - width
                }
            }

            var y: CGFloat {
                switch edge {
                case .top, .leading, .trailing: return rect.minY
                case .bottom: return rect.maxY - width
                }
            }

            var w: CGFloat {
                switch edge {
                case .top, .bottom: return rect.width
                case .leading, .trailing: return self.width
                }
            }

            var h: CGFloat {
                switch edge {
                case .top, .bottom: return self.width
                case .leading, .trailing: return rect.height
                }
            }
            path.addPath(Path(CGRect(x: x, y: y, width: w, height: h)))
        }
        return path
    }
}
