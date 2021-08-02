//
//  ArtistMediaViewCell.swift
//  GMTestCoding
//
//  Created by Hansy Enrique Abrego on 31/07/21.
//

import UIKit

class ArtisMediaViewCell: UICollectionViewCell {
    
    @IBOutlet var date: UILabel!
    @IBOutlet var name: UILabel!
    @IBOutlet var track: UILabel!
    @IBOutlet var primaryGenre: UILabel!
    @IBOutlet var price: UILabel!
}

extension ArtisMediaViewCell: CellReusable {
    static var reusableName: String { "ArtisMediaViewCellId" }
    static var nib: UINib { UINib(nibName: "ArtisMediaViewCell", bundle: .main) }
}

extension ArtisMediaViewCell: CellConfigurable {
    func set(viewModel: ArtistMediaViewModelCell) {
        name.attributedText = viewModel.name
        primaryGenre.attributedText = viewModel.genre
        track.attributedText = viewModel.track
        date.attributedText = viewModel.releaseDate
        price.attributedText = viewModel.price
    }
}


