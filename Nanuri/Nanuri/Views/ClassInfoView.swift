//
//  ClassInfoView.swift
//  Nanuri
//
//  Created by Park Gyurim on 2022/01/28.
//

import SwiftUI

struct ClassInfoView: View {
    @State var seeMore : Bool = false
    
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
//            Image("testImg")
//                .resizable()
//                .aspectRatio(contentMode: .fill)
            Color.systemDefaultGray
                .frame(width: UIScreen.main.bounds.width,
                       height: UIScreen.main.bounds.height * 0.45)
                .overlay { Text("[사진]") }
            
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
        }.edgesIgnoringSafeArea(.top)
        .navigationBarTitleDisplayMode(.inline)
        //.navigationTitle(Text("[Class Name]"))
        //.toolbar { Button { } label : { } }
    }
}

struct ClassInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ClassInfoView()
    }
}
