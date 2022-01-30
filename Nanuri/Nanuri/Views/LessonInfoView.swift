//
//  LessonInfoView.swift
//  Nanuri
//
//  Created by Park Gyurim on 2022/01/28.
//

import SwiftUI
import URLImage

struct LessonInfoView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var seeMore : Bool = false
    @State var viewOffset : CGFloat = 0
    @State var isImageTap : Bool = false
    
    let lesson : Lesson
    
    init(lesson : Lesson) {
        self.lesson = lesson
    }
    
    var Title : some View {
        HStack {
            VStack(alignment : .leading, spacing : 5) {
                Text(lesson.lessonName)
                    .font(.title)
                    .fontWeight(.bold)
                Text(convertReturnedDateString(lesson.createDate) + " #" + lesson.category)
                    .font(.headline)
                    .foregroundColor(.gray)
            }
            Spacer()
            Text("##명 / \(lesson.limitedNumber)명")
                .font(.title2)
                .fontWeight(.semibold)
        }.padding(.horizontal)
    }
    var MemberInfo : some View {
        VStack {
            Divider()
                .frame(width : UIScreen.main.bounds.width * 0.9)
            HStack {
                Image(systemName: "person.fill")
                    .font(.system(size: 25))
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.darkGray)
                    .clipShape(Circle())
                
                VStack(alignment : .leading, spacing : 10) {
                    Text(lesson.creator)
                        .font(.system(.title2, design: .rounded))
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    Text("[User Description]")
                        .font(.system(.subheadline, design: .rounded))
                        .foregroundColor(.gray)
                }.padding(.leading, 10)
                Spacer()
            }
            Divider()
                .frame(width : UIScreen.main.bounds.width * 0.9)
        }.padding(.horizontal)
    }
    
    var body: some View {
        VStack {
            TabView {
                ForEach(lesson.images, id : \.self) { image in
                    URLImage(
                        URL(string : image.lessonImgId.lessonImg)
                        ?? URL(string : "https://www.publicdomainpictures.net/pictures/280000/velka/not-found-image-15383864787lu.jpg")!
                    ) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }.edgesIgnoringSafeArea(.top)
                }
            }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.45)
            .overlay {
                VStack {
                    Spacer().frame(height : UIScreen.main.bounds.height * 0.04)
                    HStack {
                        Spacer()
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label : {
                            Image(systemName: "xmark")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                                .padding(7)
                                .background(Color.gray)
                                .clipShape(Circle())
                                .opacity(0.8)
                        }.padding()
                    }
                    Spacer()
                }
            }
            
            
//            Image("testImg")
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.45)
//                .overlay {
//                    VStack {
//                        Spacer().frame(height : UIScreen.main.bounds.height * 0.04)
//                        HStack {
//                            Spacer()
//                            Button {
//                                presentationMode.wrappedValue.dismiss()
//                            } label : {
//                                Image(systemName: "xmark")
//                                    .font(.system(size: 24))
//                                    .foregroundColor(.white)
//                                    .padding(7)
//                                    .background(Color.systemDefaultGray)
//                                    .clipShape(Circle())
//                                    .opacity(0.5)
//                            }.padding()
//                        }
//                        Spacer()
//                    }
//                }.onTapGesture { isImageTap = true }
//                .fullScreenCover(isPresented: $isImageTap) {
//                    Image("testImg")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: UIScreen.main.bounds.width)
//                        .gesture(
//                            DragGesture()
//                                .onEnded { gesture in
//                                    if gesture.translation.height > 70 {
//                                        isImageTap = false
//                                    }
//                                }
//                        )
//                }
            
            
            Title
            MemberInfo
            Text(lesson.location)
                .font(.footnote)
                .fontWeight(.light)
                .frame(maxWidth : .infinity, alignment : .trailing)
                .padding(.horizontal)

            ScrollView {
                Text(lesson.content)
                    .frame(maxWidth : .infinity, alignment : .leading)
                    .padding(.horizontal)
                    .lineLimit(seeMore ? .max : 4)
                    .font(.system(.body, design: .rounded))
                
                Button {
                    seeMore.toggle()
                } label : {
                    Text(seeMore ? "접기" : "> 더보기")
                        .foregroundColor(.gray)
                        .font(.callout)
                        .frame(maxWidth : .infinity, alignment : .trailing)
                        .padding(.horizontal)
                }
            }
            
            Spacer()
            Button {
                print("Enroll")
            } label : {
                Text("신청하기")
                    .foregroundColor(.white)
                    .frame(width : UIScreen.main.bounds.width * 0.9, height: 50)
                    .background(Color.blue)
                    .cornerRadius(20)
            }
        }.offset(y : viewOffset)
        .edgesIgnoringSafeArea(.top)
        .navigationBarTitleDisplayMode(.inline)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    if 0 < gesture.translation.height && gesture.translation.height < 50 {
                        withAnimation(.spring()) { viewOffset = gesture.translation.height }
                    }
                }
                .onEnded { gesture in
                    if gesture.translation.height > 70 {
                        withAnimation(.spring()) { presentationMode.wrappedValue.dismiss() }
                    } else {
                        withAnimation(.spring())  { viewOffset = 0 }
                    }
                }
        )
    }
}
