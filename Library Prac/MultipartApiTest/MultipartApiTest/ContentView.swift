//
//  ContentView.swift
//  MultipartApiTest
//
//  Created by Park Gyurim on 2021/09/30.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    
//    let postInfo : PostInfo = PostInfo(
//        title : "iOS Test",
//        price : 1000,
//        description : "iOS Test",
//        category : "Test",
//        camps : 1
//    )
//    let file = UIImage(named: "testImg")!.pngData()!
    
    var body: some View {
        Text("Hello, world!")
            .padding()
        Button {
            //viewModel.upload(payload: PostPayload.init(postInfo: postInfo, files: file))
            viewModel.upload()
        } label : {
            Text("Test Post")
                .frame(width : 200, height: 100)
                .background(Color.yellow)
                .cornerRadius(15)
        }
    }
}
