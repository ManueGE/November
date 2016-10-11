//
//  Date+DateFormatter.swift
//  November
//
//  Created by Manu on 19/6/16.
//  Copyright © 2016 manuege. All rights reserved.
//

import Foundation

/**
 Methods to convert `Date` to/from `String` using `DateFormatter` instances
 */
public extension Date {
    
    /**
     Returns a string representation for a given date using the given `DateFormatter`
     - parameter formatter: The provider of the `NSFormatter` used in the conversion
     - returns: the string representation of the date using the given configurator
     */
    public func string(with formatter: DateFormatter) -> String {
        return formatter.string(from: self)
    }
    
    /**
     Returns a date instantiated with the given string and the given `DateFormatter`
     - parameter string: The string to parse
     - parameter formatter: The `NSFormatter` used in the conversion
     - returns: the date instantiated with the given string and the formatter. Will return `nil` if the string couldn't be parsed
     */
    public init?(string: String, formatter: DateFormatter) {
        guard let date = formatter.date(from: string) else { return nil }
        self.init(timeIntervalSince1970: date.timeIntervalSince1970)
    }
}
