//
//  NSAttributeString.swift
//  GMTestCoding
//
//  Created by Hansy Enrique Abrego on 01/08/21.
//

import Foundation
import UIKit

extension NSAttributedString {
    static func attribute(label: String, value: String?) -> NSAttributedString {
        let attribute = NSMutableAttributedString()
        attribute.append(NSAttributedString(string: label, attributes: [:]))
        attribute.append(NSAttributedString(string: value ?? "Not Available",
                                            attributes: [.font : UIFont.italicSystemFont(ofSize: 16),
                                                         .foregroundColor : UIColor.lightGray]))
        return attribute
    }
    
    static func attribute(label: String = "Release Date: ", date: Date) -> NSAttributedString {
        let attribute = NSMutableAttributedString()
        attribute.append(NSAttributedString(string: label,
                                            attributes: [.font : UIFont.italicSystemFont(ofSize: 16),
                                                         .foregroundColor : UIColor.lightGray]))
        attribute.append(NSAttributedString(string: Formatters.format(date: date),
                                            attributes: [.font : UIFont.italicSystemFont(ofSize: 16),
                                                         .foregroundColor : UIColor.lightGray]))
        return attribute
    }
    
    static func attribute(label: String = "Price: ", price: Double?) -> NSAttributedString {
        let attribute = NSMutableAttributedString()
        attribute.append(NSAttributedString(string: label,
                                            attributes: [.font : UIFont.italicSystemFont(ofSize: 16)]))
        attribute.append(NSAttributedString(string: Formatters.format(price: price),
                                            attributes: [.font : UIFont.italicSystemFont(ofSize: 16),
                                                         .foregroundColor : UIColor.systemGreen]))
        return attribute
    }
}
