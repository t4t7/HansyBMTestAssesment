//
//  ArtistMediaViewModelCell.swift
//  GMTestCoding
//
//  Created by Hansy Enrique Abrego on 31/07/21.
//

import Foundation
import UIKit

class ArtistMediaViewModelCell: Hashable {
    
    func hash(into hasher: inout Hasher) {
        releaseDate.hash(into: &hasher)
    }
    
    let artist: ArtistMedia
    
    lazy var name = { NSAttributedString.attribute(label: "Name: ",
                                                         value: artist.artistName) }()
    
    lazy var track = { NSAttributedString.attribute(label: "Track: ",
                                                          value: artist.trackName) }()
    
    lazy var genre = { NSAttributedString.attribute(label: "Genre: ",
                                                          value: artist.primaryGenreName) }()
    
    lazy var releaseDate = { NSAttributedString.attribute(date: artist.releaseDate) }()
    lazy var price = { NSAttributedString.attribute(price: artist.trackPrice) }()
    
    init(artist: ArtistMedia) {
        self.artist = artist
    }
    
    static func ==(lhs: ArtistMediaViewModelCell, rhs: ArtistMediaViewModelCell) -> Bool {
        lhs.releaseDate == rhs.releaseDate
    }
}

