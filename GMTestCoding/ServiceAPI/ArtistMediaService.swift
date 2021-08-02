//
//  ArtistMediaService.swift
//  GMTestCoding
//
//  Created by Hansy Enrique Abrego on 30/07/21.
//

import Foundation
import Combine

protocol ArtistMediaFetchable {
    func find(artist keyWord: String) -> AnyPublisher<ArtisMediaResults, Error>
}

struct ArtistMediaService: ArtistMediaFetchable {
    let client: Client
    
    init(client: Client = HTTPClient()) {
        self.client = client
    }
    
    func find(artist keyWord: String) -> AnyPublisher<ArtisMediaResults, Error> {
        let queryString = URLQueryItem(name: "term", value: keyWord)
        return client.get([queryString])
    }
}
