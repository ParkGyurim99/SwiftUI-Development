
//
//  PostView.swift
//  WIT_combine
//
//  Created by LEESEUNGMIN on 2021/06/15.
//

import SwiftUI

struct PostView: View {
    
    @State private var postImage: Image?
    @State private var pickedImage: Image?
    @State private var showingActionSheet = false
    @State private var showingImagePicker = false
    @State private var imageData: Data = Data()
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var error: String = ""
    @State private var showingAlert = false
    @State private var alertTitle: String = "Oh No!!"
    @State private var dscText = ""
    @State private var titleText = ""
    
    func loadImage(){
        guard let inputImage = pickedImage else{ return}
        
        postImage = inputImage
    }
    func clear(){
        self.titleText = ""
        self.dscText = ""
        self.imageData = Data()
        self.postImage = nil//Image(systemName: "photo.fill")
    }
    func uploadPost(){
        if let error = errorCheck(){
            self.error = error
            self.showingAlert = true
            self.clear()
            return
        }
        
        PostService.uploadPost(caption: dscText, imageData: imageData, onSuccess : {
            self.clear()
        }){
            (errorMessage) in
            self.error = errorMessage
            self.showingAlert = true
            return
        }
        
    }
    func errorCheck() -> String? {
        if titleText.trimmingCharacters(in: .whitespaces).isEmpty || imageData.isEmpty || dscText.trimmingCharacters(in: .whitespaces).isEmpty{
            return "please add a caption and provide an image"
        }
        return nil
    }
    
    var body: some View {
        VStack(spacing : 0){
            VStack{
                if postImage != nil {
                    postImage!.resizable()
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.4)
                        .onTapGesture {
                            self.showingActionSheet = true
                        }
                } else{
//                    Image(systemName: "photo.fill").resizable()
                    Text("Click here to Choose Photo")
                        .foregroundColor(.white)
                        .frame(width: 340, height: 250)
                        .onTapGesture {
                            self.showingActionSheet = true
                        }
                }
            }
            
            .frame(width : UIScreen.main.bounds.width, height : UIScreen.main.bounds.height * 0.4)
            .background(Color.black.opacity(0.3))
            
            VStack (alignment : .leading) {
                Text("Create New Post")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                VStack(alignment : .leading) {
                // Title
                    Text("#Title")
                        .foregroundColor(.white.opacity(0.8))
                    TextEditor(text: $titleText)
                        .background(Color.red)
                        .frame(height: 30)
                    Spacer().frame(height : 20)
                    // Description
                    Text("#Description")
                        .foregroundColor(.white.opacity(0.8))
                    TextEditor(text: $dscText)
                        .frame(height: 60)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.red))
                }
                .padding()
                
                Spacer()
                
                HStack {
                    Spacer()
                    Button(action:uploadPost){
                        Text("Upload Post")
                            .foregroundColor(.white)
                            .frame(width : UIScreen.main.bounds.width * 0.7, height: 40)
                            .font(.title)
                            .padding()
                            .background(Color.secondary)
                            .cornerRadius(15)
                    }.alert(isPresented: $showingAlert) {
                        Alert(title: Text(alertTitle), message: Text(error), dismissButton: .default(Text("OK")))
                    }
                    Spacer()
                }
                .padding(.bottom, 60)
            }
            .background(Color.black.opacity(0.5))
        }
        .edgesIgnoringSafeArea(.bottom)
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage){
            ImagePicker(pickedImage: self.$pickedImage, showingImagePicker: self.$showingImagePicker, imageData:self.$imageData)
        }.actionSheet(isPresented: $showingActionSheet){
            ActionSheet(title: Text(""),buttons: [
                .default(Text("Choose")){
                    self.sourceType = .photoLibrary
                    self.showingImagePicker = true
                },
                .default(Text("Take a Photo")){
                    self.sourceType = .camera
                    self.showingImagePicker = true
                }, .cancel()
            ])
        }
        
        
    }
}
