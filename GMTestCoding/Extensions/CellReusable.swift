//
//  CellReusable.swift
//  GMTestCoding
//
//  Created by Hansy Enrique Abrego on 31/07/21.
//

import Foundation
import UIKit

protocol CellReusable {
    static var reusableName: String { get }
    static var nib: UINib { get }
}

protocol CellConfigurable {
    associatedtype ViewModelCell
    func set(viewModel: ViewModelCell)
}


extension CellReusable {
    var reusableName: String { "GenericCell" }
}
