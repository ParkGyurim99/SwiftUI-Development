//
//  SignIn.swift
//  BridgeAPITest
//
//  Created by Park Gyurim on 2021/09/28.
//

import Foundation
import Alamofire
import Combine

class viewModel : ObservableObject {
    let signInUrl : String = "http://3.36.233.180:8080/sign-in"
    let params : [String : String] = [
        "email" : "test@gmail.com",
        "password" : "test"
    ]
        
    
    var subscription = Set<AnyCancellable>()
    
    init() {
        SignIn()
    }
    
    func SignIn() {
        AF.request(signInUrl,
                   method: .post,
                   parameters: params,
                   encoder: JSONParameterEncoder.prettyPrinted
        )
            .publishDecodable(type: SignInResponse.self)
            .compactMap{ $0 }
            //.map { $0 }
            .sink { _ in //completion in
                //print("datastream done")
            } receiveValue: { receivedValue in
                print(receivedValue.type)
            }
            .store(in: &subscription)
    }
}
