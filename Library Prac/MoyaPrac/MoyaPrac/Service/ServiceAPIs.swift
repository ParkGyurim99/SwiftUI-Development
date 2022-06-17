//
//  APIService.swift
//  MoyaPrac
//
//  Created by Park Gyurim on 2022/06/16.
//

import Moya
import Foundation

enum ServiceAPIs {
    case getFloodPrediction
    case getUserInfo(userID : Int)
    case oAuthSignIn(providerType : String, accessToken : String)
    case refreshToken
}

extension ServiceAPIs: TargetType {
    var baseURL: URL { return URL(string: "")! }
    
    var path: String {
        switch self {
            case .getFloodPrediction : return "/flooding"
            case .getUserInfo(userID : let id) : return "/user/info/\(id)"
            case .oAuthSignIn(providerType: let type, accessToken : _) : return "/login/oauth/" + type
            case .refreshToken: return "/token"
        }
    }
    
    var method: Moya.Method {
        switch self {
            case .getFloodPrediction, .getUserInfo, .refreshToken : return .get
            case .oAuthSignIn(providerType: _, accessToken : _): return .post
        }
    }
    
    var task: Task {
        switch self {
            case .oAuthSignIn(providerType: _, accessToken : let accessToken) :
                let params : [String: String] = [ "accessToken" : accessToken ]
                return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
            default : return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
            case .refreshToken : return [ "Content-type": "application/json", "X-AUTH-TOKEN" : "" ]
            default : return ["Content-type": "application/json"]
        }
    }
    
    var validationType: ValidationType { .successCodes } // .successCodes : Validate success codes (only 2xx).
    // MARK: Moya validationType reference - https://github.com/Moya/Moya/blob/development/Sources/Moya/ValidationType.swift
}
