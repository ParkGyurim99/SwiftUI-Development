////
////  NewsView.swift
////  WIT
////
////  Created by LEESEUNGMIN on 2021/05/18.
////
//
//import SwiftUI
//
//struct NewsView:  View {
//    
//    @StateObject var vm: NewsViewModel = NewsViewModel()
//    
//    
//    var body: some View {
//        if vm.show == true {
//            
//                HStack{
//                    Image(systemName: "pencil.circle")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width:20)
//                        .foregroundColor(.red)
//                    Text(self.vm.news?.subject ?? "")
//                        .font(.system(size: 14))
//                        .padding(3)
//                    Button {
//                        self.vm.show = false
//                    } label : {
//                        Image(systemName: "xmark")
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width:15)
//                            .foregroundColor(.gray)
//                    }
//                }
//            
//        }
//        
//    }
//}
//
