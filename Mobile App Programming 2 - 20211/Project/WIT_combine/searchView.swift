//
//  defaultView.swift
//  WIT_combine
//
//  Created by ju young jeong on 2021/06/02.
//

import SwiftUI

struct searchView: View {
    var products : [Product] = [
        Product(name: "코듀로이 오버 칼라 아노락 스웨트셔츠", cate: "상의", subCate: "반팔", image : "product1", brand: "라퍼지스토어", price: 26535),
        Product(name: "코듀로이 오버 칼라 아노락 스웨트셔츠", cate: "상의", subCate: "반팔", image : "product1", brand: "라퍼지스토어", price: 26535),
        Product(name: "코듀로이 오버 칼라 아노락 스웨트셔츠", cate: "상의", subCate: "반팔", image : "product1", brand: "라퍼지스토어", price: 26535),]
        
    var body: some View {
        ScrollView{
            VStack{
                HStack{
                    Text("WIT").font(.custom("Roboto Regular", size: 50))
                    Spacer()
                    Text("@today").font(.custom("Roboto Regular", size: 20))
                        .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                }.padding(.horizontal)
                .padding(.bottom,20)
                
                HStack{
                    Text("How about this look?").font(.custom("Roboto Regular", size: 20))
                    Spacer()
                }.padding(.horizontal)
        
                ScrollView(.horizontal){
                    HStack(alignment: .top, spacing: 25) {
                        
                        Rectangle()
                            .fill(Color(.systemPink))
                            .cornerRadius(10)
                        .frame(width: 100, height: 180)
                        .frame(width: 120, height: 180)

                        Rectangle()
                            .fill(Color(.systemPink))
                            .cornerRadius(10)
                        .frame(width: 100, height: 180)
                        .frame(width: 120, height: 180)

                        Rectangle()
                        .fill(Color(.systemPink))
                            .cornerRadius(10)
                            .frame(width: 100, height: 180)
                        .frame(width: 120, height: 180)
                    }
                    .padding(.leading, 17)
                    .padding(.trailing, 92)
                    .padding(.top, 16)
                    .padding(.bottom, 29)
                    .frame(width: 519, height: 244)
                }//scroll view
                
                
                HStack{
                    Text("Hot Look").font(.custom("Roboto Regular", size: 30))
                    Spacer()
                }.padding(.horizontal)
                
                VStack {
                    Image("look1")
                        .resizable()
                    .frame(width: 350, height: 330)
                        .clipped()

                    HStack{
                        Image("look2")
                            .resizable()
                        .frame(width: 175, height: 198)
                            .clipped()

                        Image("look4")
                            .resizable()
                        .frame(width: 175, height: 198)
                            .clipped()
                    }
                }
            }
        }
    }
}

struct defaultView_Previews: PreviewProvider {
    static var previews: some View {
        searchView()
    }
}
