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
        "X-AUTH-TOKEN": "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ0ZXN0QGdtYWlsLmNvbSIsInJvbGVzIjpbIlJPTEVfVVNFUiJdLCJpYXQiOjE2MzMwMTQzNzIsImV4cCI6MTYzMzAxNjE3Mn0.1UlC8zPuvo7HEEiUyTNMx3BIvphRb2ac6fsfyw1G_tc"
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
    private let payload : [String : [String : String]] = [
        "postInfo" : [
            "title" : "iOS Test",
            "price" : "1000",
            "description" : "iOS Test",
            "category" : "iOS Test",
            "camps" : "[1,2]"
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
        let encoder = JSONEncoder()
        guard let jsonData = try? encoder.encode(payload) else {return}
        //print(jsonData)
        guard let jsonString = String(data : jsonData, encoding: .utf8) else { return }
        print(jsonString)
        let testString = "{\"postInfo\":{\"camps\":[1,2],\"title\":\"iOS Test\",\"description\":\"iOS Test\",\"category\":\"iOS Test\",\"price\":\"1000\"}}"

        AF.upload(multipartFormData: { [weak self] (multipartFormData) in
            guard let self = self else { return }
            
            // image
            multipartFormData.append(self.files, withName: "files", fileName : "testImg.png", mimeType: "image/png")
            // postInfo
//            for (key, value) in self.convertStringToDictionary(data: jsonData)! {
//                multipartFormData.append("\(value)".data(using: .utf8)!, withName: key, mimeType: "text/plain")
//            }
//            multipartFormData.append(jsonString.data(using: .utf8)!, withName: "postInfo", mimeType: "application/json")
            multipartFormData.append(testString.data(using: .utf8)!, withName: "postInfo", mimeType: "application/json")
            print(testString)
//            for (key, value) in self.payload {
//                print(key)
//                print(value)
//                for (keyInside, valueInsdie) in value {
//                    print(keyInside + " " + valueInsdie)
//                }
//                multipartFormData.append("\(value)".data(using: .utf8)!, withName: key, mimeType: "application/json")
//            }
            
//            // postInfo : separate
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
                    print(response.error ?? "")
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
