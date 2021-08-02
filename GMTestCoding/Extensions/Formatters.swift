//
//  Formatters.swift
//  GMTestCoding
//
//  Created by Hansy Enrique Abrego on 01/08/21.
//

import Foundation

struct Formatters {
    private static var dateFormatter: DateFormatter = {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MM-dd-yyyy"
        return dateFormat
    }()
    
    private static var numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.negativeFormat = "$-"
        numberFormatter.currencySymbol = "$"
        numberFormatter.numberStyle = .currency
        return numberFormatter
    }()
    
    static func format(date: Date) -> String { dateFormatter.string(from: date) }
    
    static func format(price: Double?) -> String {
        guard let price = price else {
            return "Not Available"
        }
        return Formatters.numberFormatter.string(from: NSNumber(value: price)) ?? "Not Available"
    }
}

