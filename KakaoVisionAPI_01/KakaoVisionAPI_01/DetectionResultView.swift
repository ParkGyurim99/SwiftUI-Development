//
//  DetectionResultView.swift
//  KakaoVisionAPI_01
//
//  Created by Park Gyurim on 2021/10/06.
//

import SwiftUI
import URLImage

struct DetectionResultView : View {
    @EnvironmentObject var viewModel : ViewModel
    
    var body : some View {
        VStack {
            if viewModel.detectionSource {
                URLImage(
                    URL(string : viewModel.inputUrl) ??
                    URL(string : "https://static.thenounproject.com/png/741653-200.png")!
                ) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
                .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.4)
                .cornerRadius(10)
                .shadow(radius: 5)
            } else {
                Image(uiImage: viewModel.selectedImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.4)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
            VStack(alignment: .trailing, spacing : 15) {
                Text("Age : \(viewModel.result?.result.faces[0].facial_attributes.age ?? -1)")
                    .font(.title2)
                    .fontWeight(.semibold)
                Text("Gender : " + viewModel.genderResult)
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            .padding()
            Spacer()
            Image("cover2")
                .resizable()
                .frame(width: UIScreen.main.bounds.width * 0.9, height : UIScreen.main.bounds.height * 0.03)
                .cornerRadius(15)
                .padding(.top, 15)
                .shadow(radius: 5)
        }.padding()
            .navigationTitle(Text("Detection Result"))
            .navigationBarTitleDisplayMode(.inline)
    }
}
