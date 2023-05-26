//
//  WithGeometryReader.swift
//  ThumbnailScrollView
//
//  Created by Park Gyurim on 2023/05/26.
//

import SwiftUI

extension ThumbnailScrollView {

    // MARK: `GeometryReader` 로 구현한 썸네일 스크롤뷰
    struct WithGeometryReader<V: View>: View {
        @Environment(\.dismiss) var dismiss
        
        @State private var showOpaqueNavigationBar: Bool = false
        
        let contents: ContentsModel
        let thumbnailSize: ThumbnailSize
        let titleAlignment: Alignment
        let navigationBarTitle: String?
        let navigationBarTrailingButtons: V
        
        init(contents: ContentsModel,
             thumbnailSize: ThumbnailSize = .medium,
             titleAlignment: Alignment = .leading,
             naviagtionBarTitle: String? = nil,
             @ViewBuilder navigationBarTrailingButtons: () -> V = { EmptyView() }
        ) {
            self.contents = contents
            self.thumbnailSize = thumbnailSize
            self.titleAlignment = titleAlignment
            self.navigationBarTitle = naviagtionBarTitle
            self.navigationBarTrailingButtons = navigationBarTrailingButtons()
        }
        
        var body: some View {
            ZStack(alignment: .top) {
                ScrollView {
                    GeometryReader { geometry in
                        let offset = geometry.frame(in: .global).minY
                        
                        contents.thumbnail
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: thumbnailSize.width, height: thumbnailSize.height + (offset > 0 ? offset : 0))
                            .clipped()
                            .overlay(Color.black.opacity(0.2))
                            .overlay(
                                VStack(alignment: titleAlignment.horizontal) {
                                    Spacer()
                                    Text(contents.date)
                                        .foregroundColor(.white.opacity(0.8))
                                    Text(contents.title)
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                        .multilineTextAlignment(.leading)
                                        .foregroundColor(.white)
                                }.padding()
                                .frame(width: thumbnailSize.width, alignment: titleAlignment)
                            ).offset(y: offset > 0 ? -offset : 0)
                            .onChange(of: offset) { newValue in
                                withAnimation { showOpaqueNavigationBar = newValue < -thumbnailSize.height * 0.4 }
                            }
                    }.frame(minHeight: thumbnailSize.height)
                    
                    VStack(alignment: .leading) {
                        Text(contents.subTitle)
                            .bold()
                            .padding(.bottom, 4)
                        Text(contents.description)
                        
                        Divider()
                      
                        Text(contents.subTitle)
                            .bold()
                            .padding(.bottom, 4)
                        Text(contents.description)
                    }.padding()
                }.edgesIgnoringSafeArea(.top)
                
                // Navigation Bar
                ZStack {
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "arrow.left")
                        }
                        
                        Spacer()
                        
                        navigationBarTrailingButtons
                    }
                    
                    if let title = navigationBarTitle {
                        Text(title)
                            .font(.system(size: 18, weight: .semibold))
                    }
                }.foregroundColor(showOpaqueNavigationBar ? Color.black : Color.white)
                .padding()
                .background(
                    Color.white
                        .opacity(showOpaqueNavigationBar ? 1 : 0)
                        .edgesIgnoringSafeArea(.top)
                        .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
                )
            }
        }
    }
}

