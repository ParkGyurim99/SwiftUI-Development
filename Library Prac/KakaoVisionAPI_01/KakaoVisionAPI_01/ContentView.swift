//
//  ContentView.swift
//  KakaoVisionAPI_01
//
//  Created by Park Gyurim on 2021/10/06.
//

import SwiftUI

// test image url : https://t1.kakaocdn.net/vision_api/static/images/01.jpg

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    var detectionWithURL : some View {
        VStack(alignment: .leading) {
            Text("Enter Face Image URL").bold()
            HStack {
                Image(systemName: "photo.circle.fill")
                TextField("Image URL", text : $viewModel.inputUrl)
            }.frame(height : 50)
        }.padding()
    }
    
    var detectionWithImage : some View {
        VStack(alignment: .leading) {
            Text("Select Face Image").bold()
            Button {
                viewModel.showImagePicker = true
            } label :{
                Image(systemName: "photo.fill.on.rectangle.fill")
                Text("Tap here to select image")
            }.frame(height : 50)
        }.padding()
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // Cover Image
                Image("cover")
                    .resizable()
                    .frame(
                        width: UIScreen.main.bounds.width * 0.9,
                        height : UIScreen.main.bounds.height * 0.2
                    ).cornerRadius(15)
                    .padding(.top, 15)
                    .shadow(radius: 5)
                
                // SubTitle
                HStack {
                    Text("Face Detection")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                    Spacer()
                }.padding()
                
                VStack(alignment : .leading) {
                    // false -> Image, true -> Image URL
                    Toggle("Detect with Image or Image-URL",
                           isOn: $viewModel.detectionSource)
                        .padding(.horizontal, 20)
                    
                    if viewModel.detectionSource { detectionWithURL }
                    else { detectionWithImage }
                }
                
                Button {
                    if viewModel.detectionSource { viewModel.detectURLImage(imageUrl: viewModel.inputUrl) }
                    else { viewModel.detectImage(image: viewModel.selectedImage.jpegData(compressionQuality: 1.0)!) }
                    viewModel.isDetectionClick = true
                } label : {
                    Text("Detect")
                        .font(.title3)
                        .frame(
                            width : UIScreen.main.bounds.width * 0.7,
                            height : UIScreen.main.bounds.height * 0.05)
                        .background(Color.yellow)
                        .cornerRadius(15)
                        .foregroundColor(.black)
                }.background(
                    NavigationLink(
                        destination: DetectionResultView()
                            .environmentObject(viewModel),
                        isActive: $viewModel.isDetectionClick) { }
                )
                Spacer()
            }
            .navigationBarTitle(Text("Kakao Vision"))
            .sheet(isPresented: $viewModel.showImagePicker) {
                ImagePicker(sourceType: .photoLibrary) { image in
                    viewModel.selectedImage = image
                }
            }
        } // NavigationView
    }
}
