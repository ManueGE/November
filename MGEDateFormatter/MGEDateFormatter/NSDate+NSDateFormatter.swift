//
//  NSDate+NSDateFormatter.swift
//  MGEDateFormatter
//
//  Created by Manu on 19/6/16.
//  Copyright © 2016 manuege. All rights reserved.
//

import Foundation

/**
 Methods to convert `NSDate` to/from `String` using `NSDateFormatter` instances
 */
public extension NSDate {
    
    /**
     Returns a string representation for a given date using the given `NSDateFormatter`
     - parameter formatter: The provider of the `NSFormatter` used in the conversion
     - returns: the string representation of the date using the given configurator
     */
    public func string(with formatter: NSDateFormatter) -> String {
        return formatter.stringFromDate(self)
    }
    
    /**
     Returns a date instantiated with the given string and the given `NSDateFormatter`
     - parameter string: The string to parse
     - parameter formatter: The `NSFormatter` used in the conversion
     - returns: the date instantiated with the given string and the formatter. Will return `nil` if the string couldn't be parsed
     */
    public convenience init?(string: String, formatter: NSDateFormatter) {
        guard let date = formatter.dateFromString(string) else { return nil }
        self.init(timeIntervalSince1970: date.timeIntervalSince1970)
    }
}
