//
//  apiTest.swift
//  MultipartApiTest
//
//  Created by Park Gyurim on 2021/10/04.
//

import SwiftUI
import Combine
import Alamofire

struct mainView : View {
    @StateObject private var viewModel = ViewModel()
    
    var body : some View {
        Text("Hello, world!")
            .padding()
        Button {
            viewModel.getPosts()
        } label : {
            Text("Test Post")
                .frame(width : 200, height: 100)
                .background(Color.yellow)
                .cornerRadius(15)
        }
        List {
//            ForEach(viewModel.Posts, id : \.self) { Post in
//                Text(Post.title)
//            }
        }
    }
}

final class ViewModel : ObservableObject {
    @Published var Posts : [Post] = []
    
    private let url = "http://3.36.233.180:8080/used-posts?"
    private var subscription = Set<AnyCancellable>()
    
    //    init() {
    //        getPosts()
    //    }
    
    func getPosts() {
        let header: HTTPHeaders = [
            "X-AUTH-TOKEN": "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ0ZXN0QGdtYWlsLmNvbSIsInJvbGVzIjpbIlJPTEVfVVNFUiJdLCJpYXQiOjE2MzMzNTc1MzksImV4cCI6MTYzMzM1OTMzOX0.--J1IlUg7-28WvTUWZ-HNX8SuULuZ7e-LIgBDgoq-G4"
        ]
        
        AF.request(url,
                   method: .get,
                   parameters: ["lastCamp":0,
                                "lastArea":0,
                                "camp":"Camp Casey"],
                   encoding: URLEncoding.default,
                   headers: header)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    //print(value)
                    do {
                        let data = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                        print(data)
                        let post = try JSONDecoder().decode(Element.self, from: data)
                        print(post)
                    }
                    catch {
                        
                    }
                case .failure(_):
                    break;
                }
            }
//            .responseJSON { json in
//
//            }
//            .publishDecodable(type:Element.self)
//            .compactMap{ $0.value }
//            .map { $0.postList }
//            .sink { completion in
//                switch completion {
//                case let .failure(error) :
//                    print(error.localizedDescription)
//                case .finished :
//                    print("finished")
//                }
//            } receiveValue: { [weak self] (recievedValue : [Post]) in
//                print(recievedValue[0].title)
//                self?.Posts = recievedValue
//            }.store(in: &subscription)
    }
}

extension ViewModel {
    struct Element : Codable {
        var campLast : Int
        var areaLast : Int
        var postList : [Post]
    }
    
    struct Post : Codable {
        let postId : Int
        let memberId : Int
        let title : String
        let price : Int
        let camp : String
        let viewCount : Int
        let image : String
        let createdAt : String
        let liked : Bool
    }
    
}
