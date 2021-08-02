//
//  UIView.swift
//  GMTestCoding
//
//  Created by Hansy Enrique Abrego on 01/08/21.
//

import UIKit

extension UIView {
    var cornerRadious: CGFloat {
        set(newValue) {
            layer.cornerRadius = newValue
            layer.masksToBounds = true
        }
        get { layer.cornerRadius }
    }
}
