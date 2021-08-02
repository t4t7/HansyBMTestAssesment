//
//  HTTPClient.swift
//  GMTestCoding
//
//  Created by Hansy Enrique Abrego on 30/07/21.
//

import Foundation
import Combine

protocol Client {
    func get<T: Codable>(_ queryItems: [URLQueryItem]) -> AnyPublisher<T, Error>
}

struct HTTPClient: Client {
    
    static let baseURL = "https://itunes.apple.com/search"
    
    static let defaultDecoder: JSONDecoder = {
        let formatDateDecoder = DateFormatter()
        formatDateDecoder.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(formatDateDecoder)
        return jsonDecoder
    }()
    
    func get<T: Codable>(_ queryItems: [URLQueryItem]) -> AnyPublisher<T, Error> {
        
        var components = URLComponents(string: HTTPClient.baseURL)!
        components.queryItems = queryItems
        let request = URLRequest(url: components.url!, timeoutInterval: 10)
        
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap({ (responseData, responseURL) in
                if let error = HTTPError.error(from: responseURL) {
                    throw error
                }
                let responseObject = try HTTPClient.defaultDecoder.decode(T.self, from: responseData)
                return responseObject
            })
            .eraseToAnyPublisher()
    }
}
