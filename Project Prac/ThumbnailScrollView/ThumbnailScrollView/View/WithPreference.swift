//
//  WithPreference.swift
//  ThumbnailScrollView
//
//  Created by Park Gyurim on 2023/05/26.
//

import SwiftUI

extension ThumbnailScrollView {
    
    // MARK: `Custom PreferenceKey`
    struct ScrollViewOffsetKey: PreferenceKey {
        typealias Value = CGFloat
        
        static var defaultValue: Value = CGFloat.zero
        static func reduce(value: inout Value, nextValue: () -> Value) { value = nextValue() }
    }
    
    // MARK: `Preference` 로 구현한 썸네일 스크롤뷰
    struct WithPreference<V: View>: View {
        @Environment(\.dismiss) var dismiss
        
        @State private var showOpaqueNavigationBar: Bool = false
        @State private var offset: CGFloat = CGFloat.zero
        
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
                    VStack(spacing: 0) {
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
                            )

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
                    }.offset(y: offset > 0 ? -offset : 0)
                    .coordinateSpace(name: "scrollSpace")
                    .background(
                        GeometryReader {
                            Color.clear
                                .preference(
                                    key: ScrollViewOffsetKey.self,
                                    value: $0.frame(in: .named("scrollSpace")).minY // or `.origin.y`
                                )
                        }
                    )
                }.edgesIgnoringSafeArea(.top)
                .onPreferenceChange(ScrollViewOffsetKey.self) { newValue in
                    withAnimation { showOpaqueNavigationBar = newValue < -thumbnailSize.height * 0.4 }
                    offset = newValue
                }
                
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
