//
//  ClassInfoView.swift
//  Nanuri
//
//  Created by Park Gyurim on 2022/01/28.
//

import SwiftUI

struct ClassInfoView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var seeMore : Bool = false
    @State var viewOffset : CGFloat = 0
    @State var isImageTap : Bool = false
    
    var Title : some View {
        HStack {
            VStack(alignment : .leading, spacing : 5) {
                Text("[Class Title]")
                    .font(.title)
                    .fontWeight(.bold)
                Text("[Created date] #[Category]")
                    .font(.headline)
                    .foregroundColor(.gray)
            }
            Spacer()
            Text("##명 / ##명")
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
                    Text("[User Name]")
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
            Image("testImg")
                .resizable()
                .aspectRatio(contentMode: .fill)
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
                                    .background(Color.systemDefaultGray)
                                    .clipShape(Circle())
                                    .opacity(0.5)
                            }.padding()
                        }
                        Spacer()
                    }
                }.onTapGesture { isImageTap = true }
                .fullScreenCover(isPresented: $isImageTap) {
                    Image("testImg")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width)
                        .gesture(
                            DragGesture()
                                .onEnded { gesture in
                                    if gesture.translation.height > 70 {
                                        isImageTap = false
                                    }
                                }
                        )
                }
            
            
            Title
            MemberInfo
            Text("[강의 진행 장소 ####]")
                .font(.footnote)
                .fontWeight(.light)
                .frame(maxWidth : .infinity, alignment : .trailing)
                .padding(.horizontal)

            ScrollView {
                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
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

struct ClassInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ClassInfoView()
    }
}
