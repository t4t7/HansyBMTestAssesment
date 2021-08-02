//
//  FormattersUT.swift
//  GMTestCodingTests
//
//  Created by Hansy Enrique Abrego on 01/08/21.
//

import Foundation
import XCTest
@testable import GMTestCoding

class FormattersUT: XCTestCase {
    
    // MARK:- Positive
    
    func testWhenFormatDate_GiveCurrentDate_ThenGetDefaultDateAsString() {
        let date = Date()
        let dateString = Formatters.format(date: date)
        XCTAssertTrue(!dateString.isEmpty)
    }
    
    func testWhenFormatPrice_GiveAPositivePrice_ThenGetPriceWithFormat() {
        let price = 2.0
        let priceString = Formatters.format(price: price)
        XCTAssertEqual(priceString, "$2.00")
    }
    
    // MARK:- Negative
    
    func testWhenFormatPrice_GiveNegativePrice_ThenGetPriceWithFormat() {
        let price = -2.0
        let priceString = Formatters.format(price: price)
        XCTAssertEqual(priceString, "$-2.00")
    }
    
    // MARK:- Boundary
    
    func testWhenFormatPrice_GiveNilPrice_ThenGetLabelNotAvailable() {
        let priceString = Formatters.format(price: nil)
        XCTAssertEqual(priceString, "Not Available")
    }
}
