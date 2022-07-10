//
//  ContentView.swift
//  ImageCompression
//
//  Created by Park Gyurim on 2022/07/10.
//

import SwiftUI
import PhotosUI

extension UIImage {
    func getSize() -> Int64? {
        guard let imageData = jpegData(compressionQuality: 1.0) else { return nil }
        return Int64(imageData.count) / 1048576
    }
    
    func getFileSizeInfo(allowedUnits: ByteCountFormatter.Units = .useMB,
                         countStyle: ByteCountFormatter.CountStyle = .memory,
                         compressionQuality: CGFloat = 1.0) -> String? {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = allowedUnits
        formatter.countStyle = countStyle
        return getSizeInfo(formatter: formatter, compressionQuality: compressionQuality)
    }
    
    func getSizeInfo(formatter: ByteCountFormatter, compressionQuality: CGFloat = 1.0) -> String? {
        guard let imageData = jpegData(compressionQuality: compressionQuality) else { return nil }
        return formatter.string(fromByteCount: Int64(imageData.count))
    }
    
    func resized(withPercentage percentage: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: size.width * percentage, height: size.height * percentage)
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    func resizedTo15MB() -> UIImage? {
        guard let imageData = self.pngData() else { return nil }
        
        var resizingImage = self
        var imageSizeKB = Double(imageData.count) / 1024
        
        while imageSizeKB > 15 * 1024 {
            guard let resizedImage = resizingImage.resized(withPercentage: 0.5),
                  let imageData = resizedImage.pngData()
            else { return nil }
            
            resizingImage = resizedImage
            imageSizeKB = Double(imageData.count) / 1024
        }
        
        return resizingImage
    }
}

struct ContentView: View {
    @State private var showPhotosPicker : Bool = false
    @State private var selectedPhotos : [UIImage] = []
    private var configuration : PHPickerConfiguration {
        var configuration = PHPickerConfiguration(photoLibrary: .shared())
        configuration.filter = .images
        configuration.selectionLimit = 7 - selectedPhotos.count
        
        return configuration
    }
    
    var body: some View {
        VStack {
            Text("\(selectedPhotos.count) / 7").bold()
            ScrollView(.horizontal) {
                HStack {
                    ForEach(selectedPhotos, id : \.self) { image in
                        VStack {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: UIScreen.main.bounds.width * 0.5,
                                       height: UIScreen.main.bounds.width * 0.5)
                                .cornerRadius(16)
                                .overlay(
                                    Button {
                                        if let index = selectedPhotos.firstIndex(of: image) {
                                            selectedPhotos.remove(at: index)
                                        }
                                    } label : {
                                        Image(systemName : "xmark")
                                            .foregroundColor(.black)
                                            .padding(8)
                                            .background(Color.gray.opacity(0.5))
                                            .clipShape(Circle())
                                    }
                                )
                            Text(image.getFileSizeInfo() ?? "")
                            Text("\(image.getSize() ?? 0)")
                        }
                    }
                }.padding()
            }
            
            Divider()

            ScrollView(.horizontal) {
                HStack {
                    ForEach(selectedPhotos, id : \.self) { image in
                        if image.getSize()! > 15 {
                            if let resized = image.resizedTo15MB() {
                                VStack {
                                    Image(uiImage: resized)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: UIScreen.main.bounds.width * 0.5,
                                               height: UIScreen.main.bounds.width * 0.5)
                                        .cornerRadius(16)
                                    Text(resized.getFileSizeInfo() ?? "")
                                    Text("\(resized.getSize() ?? 0)")
                                }
                            }
                        } else {
                            VStack {
                                Image(uiImage: image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: UIScreen.main.bounds.width * 0.5,
                                           height: UIScreen.main.bounds.width * 0.5)
                                    .cornerRadius(16)
                                Text(image.getFileSizeInfo() ?? "")
                                Text("\(image.getSize() ?? 0)")
                            }
                        }
                    }
                }.padding()
            }
            
            Button {
                showPhotosPicker.toggle()
            } label : {
                Image(systemName : "plus")
            }
            .buttonStyle(.bordered)
            .frame(maxWidth : .infinity, alignment: .trailing)
            .padding()
            
            Spacer()
        }.sheet(isPresented: $showPhotosPicker) {
            PhotosPicker(configuration: configuration,
                         isPresented: $showPhotosPicker,
                         pickerResult: $selectedPhotos)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
