//
//  ContentView.swift
//  AdvancedScrollView
//
//  Created by Park Gyurim on 2023/02/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showOpaqueNavigationBar: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                ZStack(alignment: .top) {
                    ScrollView {
                        GeometryReader { geometry in
                            let offset = geometry.frame(in: .global).minY
                            
                            ZStack {
                                Image("Sample")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: UIScreen.main.bounds.width,
                                           height: UIScreen.main.bounds.height * 0.4 + (offset > 0 ? offset : 0))
                                
                                Color.black.opacity(0.2)
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    Spacer()
                                    Text("Tips")
                                        .foregroundColor(.yellow)
                                    Text("Nov 19th, 2022")
                                        .foregroundColor(.white).opacity(0.8)
                                    Text("South Korea ends Indoor Mask Rule, but Seoul Residents are resisting...")
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
                        
                        
                        VStack {
                            Text("Amet minim mollit non deserunt ullamco est sit aliqua dolor do Hey Wassup My friend. Wanna know Amet minim mollit non deserunt ullamco est sit aliqua dolor do Hey Wassup My friend. Wanna knoAmet minim mollit non deserunt ullamco est sit aliqua dolor")
                            Text("Amet minim mollit non deserunt ullamco est sit aliqua dolor do Hey Wassup My friend. Wanna know Amet minim mollit non deserunt ullamco est sit aliqua dolor do Hey Wassup My friend. Wanna knoAmet minim mollit non deserunt ullamco est sit aliqua dolor")
                            Text("Amet minim mollit non deserunt ullamco est sit aliqua dolor do Hey Wassup My friend. Wanna know Amet minim mollit non deserunt ullamco est sit aliqua dolor do Hey Wassup My friend. Wanna knoAmet minim mollit non deserunt ullamco est sit aliqua dolor")
                            Text("Amet minim mollit non deserunt ullamco est sit aliqua dolor do Hey Wassup My friend. Wanna know Amet minim mollit non deserunt ullamco est sit aliqua dolor do Hey Wassup My friend. Wanna knoAmet minim mollit non deserunt ullamco est sit aliqua dolor")
                            Text("Amet minim mollit non deserunt ullamco est sit aliqua dolor do Hey Wassup My friend. Wanna know Amet minim mollit non deserunt ullamco est sit aliqua dolor do Hey Wassup My friend. Wanna knoAmet minim mollit non deserunt ullamco est sit aliqua dolor")
                        }.padding()
                    }
                    
                    HStack {
                        Button {
                            
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
