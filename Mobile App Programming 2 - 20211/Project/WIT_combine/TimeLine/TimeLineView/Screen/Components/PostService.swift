//
//  PostService.swift
//  WIT_combine
//
//  Created by LEESEUNGMIN on 2021/06/16.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class PostService {
    static var Posts = AuthService.storeRoot.collection("posts")
    
    static var AllPosts = AuthService.storeRoot.collection("allPosts")
    static var TimeLine = AuthService.storeRoot.collection("timeline")
    
    static func PostsUserId(userId: String) -> DocumentReference{
        return Posts.document(userId)
    }
    static func timelineUserId(userId: String) -> DocumentReference{
        return TimeLine.document(userId)
    }
    static func uploadPost(caption: String, imageData: Data , onSuccess: @escaping() -> Void,onError: @escaping(_ errorMessage: String)->Void){
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let postId = PostService.PostsUserId(userId: userId).collection("posts").document().documentID
        
        let storagePostRef = StorageService.storagePostId(postId: postId)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        StorageService.savePostPhoto(userId: userId, caption: caption, postId: postId, imageData: imageData, metadata: metadata, storagePostRef: storagePostRef, onSuccess: onSuccess, onError: onError)
    
    }
    static func loadUserPosts(userId:String,onSuccess:@escaping(_ posts : [PostModel])->Void){
        PostService.PostsUserId(userId:userId).collection("posts").getDocuments{
            (snapshot,error) in
            
            guard let snap = snapshot else{
                print("error ps")
                return
            }
            
            var posts = [PostModel]()
            
            for doc in snap.documents{
                let dict = doc.data()
                guard let decoder = try? PostModel.init(fromDictionary: dict) else{
                    return
                }
                posts.append(decoder)
            }
            onSuccess(posts)
            
        }
    }
    /****/
    static func loadAllPosts(onSuccess:@escaping(_ allPosts : [PostModel])->Void){
        AllPosts.getDocuments{
            (snapshot,error) in
            
            guard let snap = snapshot else{
                print("error ps")
                return
            }
            var allPosts = [PostModel]()
            
            for doc in snap.documents{
                let dict = doc.data()
                guard let decoder = try? PostModel.init(fromDictionary: dict) else{
                    return
                }
                allPosts.append(decoder)
            }
            onSuccess(allPosts)
            
        }
    }
    //*
    static func loadPost(postId : String, onSucess: @escaping(_ post: PostModel)->Void){
        
        PostService.AllPosts.document(postId).getDocument{
            (snapshot,error) in
            
            guard let snap = snapshot else{
                print("error")
                return
            }
            
            let dict = snap.data()
            
            guard let decoded = try? PostModel.init(fromDictionary: dict!) else{
                return
            }
            onSucess(decoded)
        }
    }
}
