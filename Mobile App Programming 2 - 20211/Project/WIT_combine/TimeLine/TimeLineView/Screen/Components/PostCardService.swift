//
//  PostCardService.swift
//  WIT_combine
//
//  Created by LEESEUNGMIN on 2021/06/17.
//

import Foundation
import Firebase
import SwiftUI

class PostCardService : ObservableObject {
    @Published var post : PostModel!
    @Published var isLiked = false
    
    func hasLikedPost(){
        isLiked = (post.likes["\(Auth.auth().currentUser!.uid)"]==true) ? true : false
    }
    func unlike() {
        post.likeCount -= 1
        isLiked = false
        
        PostService.PostsUserId(userId: post.ownerId).collection("posts").document(post.postId).updateData(["likeCount":post.likeCount,"\(Auth.auth().currentUser!.uid)":false])
        
        PostService.AllPosts.document(post.postId).updateData(["likeCount":post.likeCount,"\(Auth.auth().currentUser!.uid)":false])
        
        PostService.timelineUserId(userId: post.ownerId).collection("timeline").document(post.postId).updateData(["likeCount":post.likeCount,"\(Auth.auth().currentUser!.uid)":false])
    }
    func like() {
        post.likeCount += 1
        isLiked = true
        PostService.PostsUserId(userId: post.ownerId).collection("posts").document(post.postId).updateData(["likeCount":post.likeCount,"\(Auth.auth().currentUser!.uid)":true])
        
        PostService.AllPosts.document(post.postId).updateData(["likeCount":post.likeCount,"\(Auth.auth().currentUser!.uid)":true])
        
        PostService.timelineUserId(userId: post.ownerId).collection("timeline").document(post.postId).updateData(["likeCount":post.likeCount,"\(Auth.auth().currentUser!.uid)":true])
    }
    
}
