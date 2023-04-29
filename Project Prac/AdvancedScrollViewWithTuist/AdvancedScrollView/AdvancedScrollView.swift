//
//  AdvancedScrollView.swift
//  AdvancedScrollView
//
//  Created by Park Gyurim on 2023/02/25.
//

import SwiftUI

public struct AdvancedScrollView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showOpaqueNavigationBar: Bool = false

    private let image: String
    private let category: String
    private let date: String
    private let title: String
    private let description: String
    
    public init(image: String? = nil, category: String? = nil, date: String? = nil, title: String? = nil, description: String? = nil) {
        self.image = image ?? tempImage
        self.category = category ?? tempCategory
        self.date = date ?? tempDate
        self.title = title ?? tempTitle
        self.description = description ?? tempDescription
    }
    
    public var body: some View {
        NavigationView {
            VStack {
                ZStack(alignment: .top) {
                    ScrollView {
                        GeometryReader { geometry in
                            let offset = geometry.frame(in: .global).minY
                            
                            ZStack {
                                Image(image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: UIScreen.main.bounds.width,
                                           height: UIScreen.main.bounds.height * 0.4 + (offset > 0 ? offset : 0))
                                
                                Color.black.opacity(0.2)
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    Spacer()
                                    Text(category)
                                        .foregroundColor(.yellow)
                                    Text(date)
                                        .foregroundColor(.white).opacity(0.8)
                                    Text(title)
                                        .font(.system(size: 24, weight: .semibold))
                                        .multilineTextAlignment(.leading)
                                        .lineSpacing(27/20)
                                        .foregroundColor(.white)
                                }.padding()
                            }.frame(width: UIScreen.main.bounds.width,
                                    height: UIScreen.main.bounds.height * 0.4 + (offset > 0 ? offset : 0))
                            .offset(y: (offset > 0 ? -offset : 0))
                            .onChange(of: offset) {
                                if $0 < -70 { withAnimation { showOpaqueNavigationBar = true } }
                                else { withAnimation { showOpaqueNavigationBar = false } }
                            }
                        }.frame(minHeight: UIScreen.main.bounds.height * 0.4)
                        .edgesIgnoringSafeArea(.top)
                        
                        Text(description)
                            .padding()
                    }
                    
                    HStack {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "arrow.left")
                        }
                        
                        Spacer()
                        
                        Text("Column Post")
                            .font(.system(size: 18, weight: .semibold))
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "ellipsis")
                        }
                    }.foregroundColor(showOpaqueNavigationBar ? Color.black : Color.white)
                    .padding()
                    .background(Color.white.opacity(showOpaqueNavigationBar ? 1 : 0))
                    .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2)
                }
                
                Color.gray.opacity(0.2)
                    .overlay(Text("Comment")).frame(height: UIScreen.main.bounds.height * 0.05)
            }.toolbar(.hidden)
        }
    }
}
