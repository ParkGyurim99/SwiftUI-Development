//
//  ViewModel.swift
//  KakaoVisionAPI_01
//
//  Created by Park Gyurim on 2021/10/06.
//

import SwiftUI
import Alamofire
import Combine

final class ViewModel : ObservableObject {
    @Published var inputUrl : String = ""
    @Published var detectionSource : Bool = true // false -> Image, true -> Image URL
    @Published var isDetectionClick : Bool = false
    @Published var showImagePicker: Bool = false
    @Published var result : ResultKey?
    @Published var selectedImage : UIImage = UIImage(named: "testImage")!
    
    private var subscription = Set<AnyCancellable>()
    
    private let url = "https://dapi.kakao.com/v2/vision/face/detect"
    private let headerForURL : HTTPHeaders = [
        "Content-Type" : "application/x-www-form-urlencoded",
        "Authorization": "KakaoAK 66f9eebe07df7b30e38edba6f1188b90"
    ]
    private let headerForImage : HTTPHeaders = [
        "Content-Type": "multipart/form-data",
        "Authorization": "KakaoAK 66f9eebe07df7b30e38edba6f1188b90"
    ]
    
    var genderResult : String {
        guard let result = result else { return "none" }
        
        if result.result.faces[0].facial_attributes.gender.female > result.result.faces[0].facial_attributes.gender.male {
            return "Female"
        } else {
            return "Male"
        }
    }
    func detectURLImage(imageUrl : String) {
        AF.upload(multipartFormData: { multipartFormData in
            // image url
            multipartFormData.append(
                imageUrl.data(using: .utf8)!,
                withName: "image_url"
            )
        },
                  to: URL(string : url)!,
                  usingThreshold: UInt64.init(),
                  method : .post,
                  headers: headerForURL
        )
//            .responseJSON { (response) in
//                print(response)
//            }
            .publishDecodable(type : ResultKey.self)
            .compactMap { $0.value }
            .sink { completion in
                print(completion)
            } receiveValue : { [weak self] (recievedValue) in
                print(recievedValue)
                self?.result = recievedValue
            }.store(in: &subscription)
            
    }
    
    func detectImage(image : Data) {
        AF.upload(multipartFormData: { multipartFormData in
            // image
            multipartFormData.append(image, withName: "image",fileName: "image.jpg", mimeType: "image/jpg")
        },
                  to: URL(string : url)!,
                  usingThreshold: UInt64.init(),
                  method : .post,
                  headers: headerForImage
        )
//            .responseJSON { (response) in
//                print(response)
//            }
            .publishDecodable(type : ResultKey.self)
            .compactMap { $0.value }
            .sink { completion in
                print(completion)
            } receiveValue : { [weak self] (recievedValue) in
                print(recievedValue)
                self?.result = recievedValue
            }.store(in: &subscription)
    }
}

