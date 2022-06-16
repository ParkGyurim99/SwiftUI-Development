//
//  Service.swift
//  MoyaPrac
//
//  Created by Park Gyurim on 2022/06/16.
//

import Moya
import Foundation

enum demoApi {
    case getAllProduct
    case getSingleProduct(itemID : Int = 1)
}

extension demoApi: TargetType {
    var baseURL: URL { return URL(string: "https://fakestoreapi.com")! }
    
    var path: String {
        switch self {
            case .getAllProduct : return "/products"
            case .getSingleProduct(itemID: let id) : return "/products/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
            case .getAllProduct, .getSingleProduct(itemID: _) : return .get
        }
    }
    
    var task: Task {
        return .requestPlain
//        switch self {
//            case .getAllProduct :
//                let params: [String: Any] = [ : ]
//                return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
//        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
