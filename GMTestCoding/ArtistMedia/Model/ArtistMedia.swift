//
//  ArtistMedia.swift
//  GMTestCoding
//
//  Created by Hansy Enrique Abrego on 30/07/21.
//

import Foundation

struct ArtisMediaResults: Codable {
    let resultCount: Int
    let results: [ArtistMedia]
}

struct ArtistMedia: Codable, Hashable {
    let artistName: String
    let trackName: String?
    let releaseDate: Date
    let primaryGenreName: String
    let trackPrice: Double?
}
