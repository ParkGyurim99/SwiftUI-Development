//
//  ContentView.swift
//  CouponList
//
//  Created by Park Gyurim on 2022/02/22.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("How about this place?")
                    .font(.system(.title2, design : .rounded))
                    .fontWeight(.semibold)
                Spacer()
            }.padding()

            ScrollView(.horizontal, showsIndicators: true) {
                HStack {
                    //ForEach(viewModel.shopsRandom, id : \.self) { shop in
                    ForEach(0..<5, id : \.self) { shop in
                        NavigationLink(destination :
                                        Text("")
//                                CouponInfoView(
//                                    memberId : viewModel.memberInfo.memberId,
//                                    viewModel:
//                                        CouponInfoViewModel(shop.shopId, image : shop.image))
                        ) {
                            VStack(spacing : 0) {
                                KFImage(URL(string: "https://www.apple.com/newsroom/images/live-action/new-store-opening/Apple-Store-fifth-avenue-new-york-redesign-exterior-091919_big.jpg.large.jpg")!
                                ).resizable()
                                .fade(duration: 0.5)
                                .aspectRatio(contentMode: .fill)
                                .clipped()
                                .frame(width : UIScreen.main.bounds.width * 0.6, height: UIScreen.main.bounds.height * 0.13)
                                
                                VStack(spacing : 5) {
                                    //Text(shop.name)
                                    Text("shop.name \(shop)")
                                        .fontWeight(.semibold)
                                        .foregroundColor(.black)
                                        .minimumScaleFactor(0.4)
                                        .lineLimit(1)
                                        .background(Color.gray)
                                    Text("[Shop description]")
                                        .foregroundColor(.gray)
                                        .minimumScaleFactor(0.4)
                                        .lineLimit(1)
                                        .background(Color.gray)
                                    
                                    //Text(shop.benefit)
                                    Text("shop.benefit \(shop)")
                                            .foregroundColor(Color(red: 165/255, green: 123/255, blue: 255/255))
                                            .font(.caption)
                                            .fontWeight(.medium)
                                            .minimumScaleFactor(0.4)
                                            .lineLimit(1)
                                            .padding(4)
                                            .padding(.horizontal, 4)
                                            .background(Color(red: 165/255, green: 123/255, blue: 255/255).opacity(0.1))
                                            .cornerRadius(50)
                                    
                                }.frame(width : UIScreen.main.bounds.width * 0.6, height: UIScreen.main.bounds.height * 0.1, alignment: .leading)
                                .background(Color.white)
                            }.clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                    }
            }.padding(.horizontal)
        }
            
            Color.black
                .frame(width : UIScreen.main.bounds.width, height : 4)
                .padding(.vertical, 5)
            
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
