//
//  NSAttributedStringUT.swift
//  GMTestCodingTests
//
//  Created by Hansy Enrique Abrego on 01/08/21.
//

import Foundation
import XCTest
@testable import GMTestCoding

class NSAttributedStringUT: XCTestCase {
    // MARK:- Positive
    
    func testWhenGetAttribute_GivenATestString_ThenCreatesAnAttributeString() {
        let label = "Test label: ", value = "Test Value"
        let attribute = NSAttributedString.attribute(label: label, value: value)
        XCTAssertEqual("Test label: Test Value", attribute.string)
    }
    
    func testWhenGetAttribute_GivenADate_ThenCreatesAnAttributeStringWithADate() {
        let label = "Label Date: "
        let date = Date()
        let attribute = NSAttributedString.attribute(label: label, date: date)
        XCTAssertTrue(!attribute.string.isEmpty)
    }
    
    func testWhenGetAttribute_GivenAPriceAndDefaultLabel_ThenCreatesAnAttributeStringWithAPrice() {
        let price = 3.0
        let attribute = NSAttributedString.attribute(price: price)
        XCTAssertEqual("Price: $3.00", attribute.string)
    }
    

    // MARK:- Negative
    
    func testWhenGetAttribute_GivenANilValue_ThenAddNotAvailableLabel() {
        let label = "Nil Value: "
        let attribute = NSAttributedString.attribute(label: label, value: nil)
        XCTAssertEqual("Nil Value: Not Available", attribute.string)
    }
    
    func testWhenGetAttribute_GivenADateAndDefaultTitle_ThenCreatesAnAttributeStringWithADate() {
        let date = Date()
        let attribute = NSAttributedString.attribute(date: date)
        XCTAssertTrue(!attribute.string.isEmpty)
    }
    
    func testWhenGetAttribute_GivenANegativePriceAndDefaultLabel_ThenCreatesAnAttributeStringWithAPrice() {
        let price = -6.0
        let attribute = NSAttributedString.attribute(price: price)
        XCTAssertEqual("Price: $-6.00", attribute.string)
    }
    
    // MARK:- Boundary
    
    func testWhenGetAttribute_GivenANilPrice_ThenCreatesAnAttributeWithNotAvailable() {
        let attribute = NSAttributedString.attribute(price: nil)
        XCTAssertEqual("Price: Not Available", attribute.string)
    }
}
