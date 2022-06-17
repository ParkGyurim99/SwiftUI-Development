//
//  ContentViewModel.swift
//  MoyaPrac
//
//  Created by Park Gyurim on 2022/06/17.
//

import Foundation
import Alamofire
import Combine
import Moya
import CombineMoya

final class ContentViewModel : ObservableObject {
    private let provider = MoyaProvider<ServiceAPIs>()
    private var subscription = Set<AnyCancellable>()
    
    func getFloodingPrediction() {
//        provider.request(.getFloodPrediction) { response in
//            switch response {
//                case .success(let result) :
//                    guard let data = try? result.map(DataResponse<PredictionInfo>.self) else { return }
//                    print(data)
//                case .failure(let err):
//                    print(err.localizedDescription)
//            }
//        }
        
        // CombineMoya
        provider.requestPublisher(.getFloodPrediction)
            .sink { completion in
                switch completion {
                    case let .failure(error) :
                        print("Get FloodPrediction Fail : " + error.localizedDescription)
                    case .finished :
                        print("Get FloodPrediction Finished")
                }
            } receiveValue: { recievedValue in
                guard let responseData = try? recievedValue.map(DataResponse<PredictionInfo>.self) else { return }
                print(responseData)
            }.store(in : &subscription)
    }
}
