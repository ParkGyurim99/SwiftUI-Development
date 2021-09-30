//
//  ContentViewModel.swift
//  MultipartApiTest
//
//  Created by Park Gyurim on 2021/09/30.
//

import Foundation
import SwiftUI
import Alamofire

final class ContentViewModel : ObservableObject {
    private let url = "http://3.36.233.180:8080/used-posts"
    private let header : HTTPHeaders = [
        "Content-Type": "multipart/form-data",
        "X-AUTH-TOKEN": "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ0ZXN0QGdtYWlsLmNvbSIsInJvbGVzIjpbIlJPTEVfVVNFUiJdLCJpYXQiOjE2MzMwMTI0OTQsImV4cCI6MTYzMzAxNDI5NH0.s8BduFjUkBUyQeDqiJDANy5evHQyyi9XXGsGnhzTViU"
    ]
    
    private let files = UIImage(named: "testImg")!.pngData()! // Type : Data
    private let postPayload : PostPayload = PostPayload(
        postInfo: .init(
            title : "iOS Test",
            price : 1000,
            description : "iOS Test",
            category : "iOS Test",
            camps : [1, 2]
        )
    )
    private let payload : [String : Any] = [
        "postInfo" : [
            "title" : "iOS Test",
            "price" : 1000,
            "description" : "iOS Test",
            "category" : "iOS Test",
            "camps" : [1, 2]
        ]
    ]
    
    func convertStringToDictionary(data: Data) -> [String:AnyObject]? {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
            return json
        } catch { print("Something went wrong") }
        return nil
    }
    
    func upload() { //(with payload : PostPayload)
//        let encoder = JSONEncoder()
//        let jsonData = try! encoder.encode(postPayload)
//        let test = convertStringToDictionary(data: jsonData)
//        print(test!)
        
        AF.upload(multipartFormData: { [weak self] (multipartFormData) in
            guard let self = self else { return }
            
            // image
            multipartFormData.append(self.files, withName: "files", fileName : "testImg.png", mimeType: "image/png")
            // postInfo
            for (key, value) in self.convertStringToDictionary(data: jsonData)! {
                multipartFormData.append("\(value)".data(using: .utf8)!, withName: key, mimeType: "text/plain")
            }
            
//            print(self.payload)
//            for (key, value) in self.payload {
//                for (keyInsdie, valueInside) in value.self {
//                    multipartFormData.append("\(valueInside)".data(using: .utf8)!,
//                                             withName: keyInside,
//                                             mimeType: "application/json"
//                    )
//                }
//                print(key)
//                print(value)
//                multipartFormData.append("\(value)".data(using: .utf8)!, withName: key, mimeType: "application/json")
            }
            
//            // postInfo
//            multipartFormData.append("iOS TEST title".data(using: .utf8)!, withName: "postInfo[title]")
//            multipartFormData.append("1000".data(using: .utf8)!, withName: "postInfo[price]")
//            multipartFormData.append("iOS TEST desc".data(using: .utf8)!, withName: "postInfo[description]")
//            multipartFormData.append("iOS TEST cate".data(using: .utf8)!, withName: "postInfo[category]")
//            multipartFormData.append("1".data(using: .utf8)!, withName: "postInfo[camp]")
        }, to: URL(string : url)!, usingThreshold: UInt64.init(), method : .post, headers: header)
            .responseJSON { (response) in
                guard let statusCode = response.response?.statusCode else { return }
                switch statusCode {
                case 201 :
                    print("upload success : \(statusCode)")
                    print(response)
                default :
                    print(response.description)
                    print("upload fail : \(statusCode)")
                }
            }
    }
    

}

//    withname – 서버에서 요구하는 key값
//
//    fileName – 전송될 파일이름
//
//    mimeType – 타입에맞게 image/jpg, image/png, text/plain, 등 타입
