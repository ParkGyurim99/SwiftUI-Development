//
//  ProfileService.swift
//  WIT_combine
//
//  Created by ju young jeong on 2021/06/17.
//

import UIKit

class ProfileService: ObservableObject {
    @Published var posts: [PostModel] = []
    @Published var allPosts: [PostModel] = []
    
    func loadUserPosts(userId: String){
        PostService.loadUserPosts(userId: userId){
            (posts) in
            self.posts = posts
        }
    }
    func loadAllPosts(){
        PostService.loadAllPosts{
            (posts) in
            self.allPosts = posts
        }
    }
}
