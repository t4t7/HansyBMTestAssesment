//
//  HTTPError.swift
//  GMTestCoding
//
//  Created by Hansy Enrique Abrego on 31/07/21.
//

import Foundation

enum HTTPError: Error {
    case unkowedResponse
    case netWorkError
    /// Error for http codes 4xx
    case requestError(Int)
    /// Error for http codes 5xx
    case serverError(Int)
    /// Case when we can not decoding a object
    case decodingError(DecodingError)
    /// Catch somenthing that we must handle
    case unHandledResponse
}

extension HTTPError {
    static func error(from response: URLResponse?) -> HTTPError? {
        guard let httpResponse = response as? HTTPURLResponse else {
            return HTTPError.unkowedResponse
        }
        
        switch httpResponse.statusCode {
            case 200...299:
                return nil
                
            case 400...499:
                return .requestError(httpResponse.statusCode)
                
            case 500...599:
                return .serverError(httpResponse.statusCode)
                
            default:
                return .unHandledResponse
        }
    }
}
