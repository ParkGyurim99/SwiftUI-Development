//
//  ContentView.swift
//  ItemInfo
//
//  Created by Park Gyurim on 2022/06/08.
//

import SwiftUI

enum ItemInfoDisplayMode {
    case half
    case full
}

struct ItemInfoView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var displayMode : ItemInfoDisplayMode = .half
    @State private var offsetDown = CGSize.zero // ⬇️
    @State private var offsetUp = CGSize.zero // ⬆️
    @State private var ImageViewOffset = CGSize.zero

    var imageArea : some View {
        VStack {
            ZStack(alignment : .bottom) {
                TabView {
                    ForEach(0..<4, id : \.self) { _ in Color.indigo }
                }.tabViewStyle(PageTabViewStyle())
                
                TabView {
                    ForEach(0..<4, id : \.self) {_ in
                        Color.white.opacity(0)
                    }
                }.frame(height : 40)
                    .tabViewStyle(PageTabViewStyle())
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                    .padding(.bottom, 40)
            }.frame(width : UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.38 + offsetDown.height)
            Spacer()
        }
    }
    
    var textArea : some View {
        VStack {
            Spacer()
            VStack(alignment : .leading) {
                // Title
                HStack(spacing: 10) {
                    VStack(alignment : .leading, spacing: 10) {
                        Text("Title")
                            .font(.system(.largeTitle, design: .rounded))
                            .fontWeight(.bold)
                            .lineLimit(1)
                            .minimumScaleFactor(0.4)
                        HStack(spacing : 5) {
                            Text("2021-10-01 00:00:00")
                            Text("|").foregroundColor(.yellow)
                            Text("0 View")
                            Text("|").foregroundColor(.yellow)
                            Text("0 Likes")
                        }.font(.system(size : 11, weight : .semibold))
                            .lineLimit(1)
                            .minimumScaleFactor(0.4)
                    }.foregroundColor(.black.opacity(0.8))
                    Spacer()
                    HStack(spacing : 5) {
                        Text("$")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Text("0")
                            .foregroundColor(.yellow)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }.lineLimit(1)
                    .minimumScaleFactor(0.4)
                }
                
                // User Area
                HStack {
                    Color.gray
                        .frame(width: 50, height: 50)
                        .cornerRadius(15)
                    
                    VStack(alignment : .leading, spacing: 5) {
                        Text("username")
                            .fontWeight(.semibold)
                        Text("description")
                            .font(.subheadline)
                    }
                    Spacer()
                    Image(systemName: "info.circle")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .padding(8)
                        .background(Color.gray)
                        .cornerRadius(10)
                        .padding(.trailing, 5)
                }
                .padding(5)
                .background(Color.gray)
                .cornerRadius(15)
                .shadow(radius: 1)
                .padding(.bottom, 10)
                
                // Camp Info
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(0..<4, id : \.self) {
                            Text("camp \($0)")
                                .foregroundColor(.yellow)
                                .font(.system(size : 12, weight : .semibold))
                                .padding(6)
                                .background(Color.gray)
                                .cornerRadius(10)
                                .shadow(radius: 1)
                                .padding(.leading, 2)
                        }
                    }.frame(height : 30)
                }
                
                Divider()
                    .padding(.vertical, 3)
                
                // Item Desc.
                VStack(alignment : .leading, spacing: 10) {
                    HStack {
                        Text("About Item")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.yellow)
                        Text("#etc.")
                            .foregroundColor(.gray)
                            .font(.system(size : 12, weight : .semibold))
                            .padding(6)
                            .background(Color.gray)
                            .cornerRadius(10)
                            .shadow(radius: 1)
                            .padding(.leading, 2)
                        Spacer()
                        
                        Button {
                            
                        } label : {
                            Image(systemName : "ellipsis")
                                .foregroundColor(.black)
                                .font(.system(size : 15, weight : .bold))
                        }
                    }
                    ScrollView {
                        Text("DescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescription")
                            .lineLimit(displayMode == .half ? 3 : .max)
                    }.disabled(displayMode == .half)
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .frame(width : UIScreen.main.bounds.width)
            .frame(maxHeight : displayMode == .half ? (UIScreen.main.bounds.height * 0.53 - offsetUp.height) : .infinity)
            .background(Color.white)
            .cornerRadius(25)
        }
    }
    
    var body: some View {
            ZStack {
                imageArea
                
                textArea
                    .offset(x: 0, y: offsetDown.height)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                switch displayMode {
                                    case .half:
                                        if 0 < gesture.translation.height && gesture.translation.height < 100 {
                                            self.offsetDown = gesture.translation
                                        } else if -100 < gesture.translation.height && gesture.translation.height < 0 {
                                            self.offsetUp = gesture.translation
                                        } else if gesture.translation.height < -120 {
                                            withAnimation { displayMode = .full }
                                        }
                                    case .full:
                                        if 0 < gesture.translation.height && gesture.translation.height < 100 {
                                            self.offsetDown = gesture.translation
                                        } else if 120 < gesture.translation.height {
                                            withAnimation {
                                                self.offsetDown = .zero
                                                displayMode = .half
                                            }
                                        }
                                }
                            }
                            .onEnded { _ in
                                withAnimation {
                                    self.offsetDown = .zero
                                    self.offsetUp = .zero
                                }
                            }
                    )
                
                Button {
                    
                } label : {
                    HStack {
                        Text("Knock Now!")
                            .font(.system(size : 20, weight : .bold))
                        Image(systemName : "hand.wave.fill")
                            .font(.system(size : 20, weight : .bold))
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.08)
                    .background(Color.yellow)
                    .cornerRadius(30)
                }.padding(.top, 5)
                .frame(maxWidth : .infinity, alignment : .center)
                .background(Color.white)
                .frame(maxHeight : .infinity, alignment: .bottom)
            }.navigationBarTitle(Text("Item Info"))
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Image(systemName : "heart.fill")
                                            .font(.system(size : 15, weight : .bold))
                                            .foregroundColor(.pink))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ItemInfoView()
    }
}
