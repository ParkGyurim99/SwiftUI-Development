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
        "X-AUTH-TOKEN": "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ0ZXN0QGdtYWlsLmNvbSIsInJvbGVzIjpbIlJPTEVfVVNFUiJdLCJpYXQiOjE2MzM2MjYxODYsImV4cCI6MTYzMzYyNzk4Nn0.xbAz6_xC8Ma1RAPfXAQizol80a-240JnsbDnC66SoUo"
    ]
    
    private let file1 = UIImage(named: "testImg")!.pngData()! // Type : Data
    private let file2 = UIImage(named: "testImg2")!.jpegData(compressionQuality: 1.0)! // Type : Data
    private let payload : [String : [String : Any]] = [
        "postInfo" : [
            "title" : "Test iOS",
            "price" : 1000,
            "description" : "Multiple Image Test",
            "category" : "etc",
            "camps" : [1,2]
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
        AF.upload(multipartFormData: { [weak self] (multipartFormData) in
            guard let self = self else { return }
            
            // image
            multipartFormData.append(self.file1, withName: "files", fileName : "testImg.png", mimeType: "image/png")
            multipartFormData.append(self.file2, withName: "files", fileName : "testImg.png", mimeType: "image/jpeg")
            
            // postInfo
            //print(try? JSONSerialization.data(withJSONObject: self.payload["postInfo"] as Any) ?? Data() as Any)
            multipartFormData.append(try! JSONSerialization.data(withJSONObject: self.payload["postInfo"]!), withName: "postInfo", mimeType: "application/json")
        }, to: URL(string : url)!, usingThreshold: UInt64.init(), method : .post, headers: header)
            .responseJSON { (response) in
                guard let statusCode = response.response?.statusCode else { return }
                switch statusCode {
                case 201 :
                    print("upload success : \(statusCode)")
                    print(response)
                default :
                    print(response.error ?? "")
                    print(response.description)
                    print("upload fail : \(statusCode)")
                }
            }
    }
}
