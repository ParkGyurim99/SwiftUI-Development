//
//  ContentView.swift
//  MoyaPrac
//
//  Created by Park Gyurim on 2022/06/16.
//

import SwiftUI
import Moya
import CombineMoya
import Combine
import Alamofire

struct Product : Codable {
    var product : ProductInfo
    
    struct ProductInfo : Codable {
        var id : Int
        var title : String
        var price : String
        var category : String
        var description : String
        var image : String
        var rating : Rating
    }

    struct Rating : Codable {
        var count : Int
        var rate : String
    }
}

struct ContentView: View {
    let provider = MoyaProvider<demoApi>()

    var body: some View {
        Button("Get Random") {
//            AF.request("https://fakestoreapi.com/products/1",
//                       method: .get)
//            .responseJSON {
//                print($0)
//            }
            
            provider.request(.getSingleProduct(itemID: 1)) { response in
                switch response {
                    case .success(let result) :
                        print(result.statusCode, result.request)
                        //print(try? result.mapJSON())
                        let data = try? result.map(Product.self)
                        print(data)
                    case .failure(let err):
                        print(err.localizedDescription)
                }
            }
//            _ = provider.requestPublisher(.getSingleProduct(itemID: 1))
//                .sink { completion in
//                    switch completion {
//                        case let .failure(_) :
//                            print("fail with error")
//                        case .finished :
//                            print("finish")
//                    }
//                } receiveValue: { recievedValue in
//                    print(recievedValue)
//                }

        }.buttonStyle(.borderedProminent)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
