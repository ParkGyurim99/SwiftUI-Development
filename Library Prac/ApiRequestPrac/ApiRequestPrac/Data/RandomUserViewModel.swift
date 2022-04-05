//
//  RandomUserViewModel.swift
//  ApiRequestPrac
//
//  Created by Park Gyurim on 2021/09/25.
//

import Foundation
import Combine
import Alamofire

class RandomUserViewModel : ObservableObject {
    //MARK: Properties
    var subscription = Set<AnyCancellable>() // 메모리에서 없애기 위해서
    
    @Published var randomUsers : [RandomUser] = []
    
    var baseUrl = "https://randomuser.me/api/?results=100"
    
    // Alamofire call
    init() {
        fetchRandomUsers()
    }
    
    func fetchRandomUsers() {
        AF.request(baseUrl)
            .publishDecodable(type: RandomUserResponse.self) // <- Parsing!! : 명시된 타입으로
            .compactMap{ $0.value } // 값이 있는 것만 가져와서 자동적으로 언래핑
            .map { $0.results } // 값 중에 results 만 가져오겠다
            .sink { _ in //completion in
                //print("datastream done")
            } receiveValue: { [weak self] (recievedValue : [RandomUser]) in
                //print("recieved value count : \(recievedValue.count)")
                self?.randomUsers = recievedValue
            }
            .store(in: &subscription)
            // 구독이 완료되었으면 store를 통해서 메모리에서 제거
    }
}
