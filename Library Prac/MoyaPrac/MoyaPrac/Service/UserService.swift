//
//  UserService.swift
//  MoyaPrac
//
//  Created by Park Gyurim on 2022/06/17.
//

import Foundation
import Alamofire

// final class UserService {}

class Interceptor : RequestInterceptor {
    func adapt(_ urlRequest: URLRequest,
               for session: Session,
               completion: @escaping (Result<URLRequest, Error>) -> Void
    ) {
        let urlRequest = urlRequest
        
        // Add something in header
        // urlRequest.headers.add(name: "header name", value: "header value")
        
        completion(.success(urlRequest))
    }

    func retry(_ request: Request,
               for session: Session,
               dueTo error: Error,
               completion: @escaping (RetryResult) -> Void
    ) {
        // Retry request by statusCode type
        
        // guard let statusCode = request.response?.statusCode else { return }
        // switch statusCode {
        //    case .. : completion(.retry)
        // }
        
        completion(.doNotRetry)
    }
}
