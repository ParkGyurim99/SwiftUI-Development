//
//  UsedWritingView.swift
//  UsedWritingTest
//
//  Created by Park Gyurim on 2022/03/07.
//

import SwiftUI

enum category : String, CaseIterable {
    case Digital = "Digital"
    case Interior = "Interior"
    case Lifestyle = "Lifestyle"
    case Beauty = "Beauty"
    case Fashion = "Fashion"
    case Other = "Other"
}

struct UsedWritingView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var step = 1
    @State var titleText : String = ""
    @State var contentText : String = "What are you trading?"
    @State var selectedCateogry : category? = nil
    @State var priceText : String = ""
    @State var showCampSelector : Bool = false
    @State var showFillAlert : Bool = false
    @State var showProgress : Bool = false
    
//    init() {
//        UIScrollView.appearance().keyboardDismissMode = .onDrag
//    }
    var body: some View {
        ZStack(alignment : .top) {
            VStack(spacing : 0) {
                HStack(spacing : 15) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label : {
                        Image(systemName : "xmark")
                            .foregroundColor(.black)
                    }
                    VStack(alignment : .leading) {
                        Text("Create Post")
                            .font(.system(size : 16))
                            .fontWeight(.semibold)
                        Text("Step \(step)/2")
                            .font(.system(size : 12))
                            .fontWeight(.light)
                    }
                    Spacer()
                    Button {
                        if step == 1 {
                            // fill check
                            if titleText == "" || contentText == "" || contentText == "What are you trading?" {
                                showFillAlert = true
                            } else {
                                withAnimation { step = 2 }
                            }
                        } else {
                            // API 호출
                            if priceText == "" || selectedCateogry == nil {
                                showFillAlert = true
                            } else {
                                showProgress = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTimeInterval.seconds(5)) {
                                    presentationMode.wrappedValue.dismiss()
                                }
                            }
                        }
                    } label : {
                        Text("Done")
                            .font(.system(size : 14))
                            .foregroundColor(.gray)
                            //.foregroundColor(.black)
                    }
                }.padding(.horizontal)
                .padding(.vertical, 5)
                .background(Color.white.shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 2))
                if step == 1 {
                    VStack {
                        TextField("Title", text: $titleText)
                        Divider()
                        TextEditor(text: $contentText)
                            .onTapGesture { if contentText == "What are you trading?" { contentText = "" } }
                            .foregroundColor(contentText == "What are you trading?" ? .gray : .black)
                        Spacer()
                        HStack {
                            Image(systemName : "camera")
                                .padding(.horizontal)
                            Button {
                                withAnimation { showCampSelector = true }
                            } label : {
                                Image(systemName : "location")
                                    .padding(.horizontal)
                                    .padding(.vertical, 10)
                            }
                            Spacer()
                        }.frame(width : UIScreen.main.bounds.width)
                        .background(Color.white.shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: -2))
                    }.padding()
                } else {
                    VStack(alignment : .leading) {
                        Text("How much is it?")
                            .fontWeight(.bold)
                        HStack {
                            Text("$ ")
                            TextField("Amount", text : $priceText)
                                .keyboardType(.decimalPad)
                        }.padding()
                        .background(Color(red: 245/255, green: 245/255, blue: 245/255))
                        .cornerRadius(8)
                        
                        Text("Select Category")
                            .fontWeight(.bold)
                            .padding(.vertical)
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]) {
                            ForEach(category.allCases , id : \.self) { cate in
                                Button {
                                    selectedCateogry = cate
                                } label : {
                                    HStack {
                                        Text(cate.rawValue)
                                            .fontWeight(.semibold)
                                            .frame(width : UIScreen.main.bounds.width * 0.24, height : UIScreen.main.bounds.height * 0.044)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 20)
                                                    .stroke(selectedCateogry == cate ? .yellow : .gray, lineWidth: 1)
                                            )
                                    }.foregroundColor(selectedCateogry == cate ? .yellow : .gray)
                                    .font(.system(size : 14))
                                }.buttonStyle(.plain)
                                
                            }
                        }
                        Spacer()
                    }.padding()
                }
            }.frame(width : UIScreen.main.bounds.width)
            .overlay(
                    Color.black.opacity(showCampSelector || showProgress ? 0.5 : 0)
                        .edgesIgnoringSafeArea(.vertical)
                        .onTapGesture {
                            withAnimation { showCampSelector = false }
                        }
                        .overlay(ProgressView().opacity(showProgress ? 1 : 0))
            )
            
             if showCampSelector {
                VStack {
                    Text("SelectCamp")
                }.frame(width : UIScreen.main.bounds.width, height : UIScreen.main.bounds.height * 0.45)
                .background(Color.white)
                .cornerRadius(20)
                .transition(.move(edge: .bottom))
                .offset(y: UIScreen.main.bounds.height * 0.55)
                .zIndex(5)
             }
        }.navigationBarHidden(true)
        .alert(isPresented: $showFillAlert) {
            Alert(title: Text("Please fill all field"), dismissButton: .default(Text("OK")) )
        }
    }
}

struct UsedWritingView_Previews: PreviewProvider {
    static var previews: some View {
        UsedWritingView()
    }
}
