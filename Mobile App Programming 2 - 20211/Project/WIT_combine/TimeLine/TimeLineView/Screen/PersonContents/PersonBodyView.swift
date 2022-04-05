//
//  PersonBodyView.swift
//  WIT
//
//  Created by LEESEUNGMIN on 2021/05/21.
//

import SwiftUI
import Firebase
import FirebaseAuth


struct PersonBodyView: View {

    
    @EnvironmentObject var session: SessionStore
    
    @StateObject var profileService = ProfileService()
    
    var colWidth: CGFloat
    
    var body: some View {
 
            ScrollView{
                ForEach(self.profileService.allPosts, id:\.postId){
                    (post) in
                    PostCardImage(post:post)
                }
            }
            .onAppear{
                self.profileService.loadAllPosts()
            }
    }
}
extension View {
    func getSafeArea() -> UIEdgeInsets {
        return UIApplication.shared.windows.first?.safeAreaInsets ?? UIEdgeInsets(top:0,left:0,bottom:0,right:0)
    }
}
