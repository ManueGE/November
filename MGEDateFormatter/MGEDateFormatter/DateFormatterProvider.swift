//
//  DateFormatterProvider.swift
//  MGEDateFormatter
//
//  Created by Manu on 16/6/16.
//  Copyright © 2016 manuege. All rights reserved.
//

import Foundation

/**
 A protocol that must conform the objects that can provide a `NSDateFormatter`. The formatters created 
 by instances of this protocol are chached using the `cacheKey` parameter.
 */
public protocol DateFormatterProvider {
    /// The name used to cache the formatter. It should be unique for each formatter.
    var cacheKey: String { get }
    
    /**
     When a new `NSDateFormatter` is created, this method is called in order to configure the formatter as needed.
     - parameter formatter: the plain `NSDateFormatter` which must be configured
     */
    func configure(formatter: NSDateFormatter)
}

/*
 Methods used to cache and retrieve `DateFormatterProvider` instances
 */
internal extension NSDateFormatter {
    
    /// Dictionary to store all the cached formatters
    private static var formatters: [String: NSDateFormatter] = [:]
    
    /**
     Return the `NSDateFormatter` for the given `DateFormatterProvider`. If the formatter has not been cached yet, it 
     is created, cached and returned
     */
    static func formatter(with provider: DateFormatterProvider) -> NSDateFormatter {
        
        if let formatter = formatters[provider.cacheKey] {
            return formatter
        }
        
        let formatter = NSDateFormatter()
        provider.configure(formatter)
        formatters[provider.cacheKey] = formatter
        return formatter
    }
}

/**
 Methods to convert `NSDate` to/from `String` using `DateFormatterProvider` instances
 */
public extension NSDate {
    
    // MARK: String from date
    
    /**
     Returns a string representation for a given date using the given configurator
     - parameter provider: The provider of the `NSFormatter` used in the conversion
     - returns: the string representation of the date using the given configurator
     */
    func string(with provider: DateFormatterProvider) -> String {
        let formatter = NSDateFormatter.formatter(with: provider)
        return self.string(with: formatter)
    }
    
    // MARK: Date from string
    
    /**
     Returns a date instantiated with the given string and the formatter provided by the provider
     - parameter string: The string to parse
     - parameter provider: The provider of the `NSFormatter` used in the conversion
     - returns: the date instantiated with the given string and the formatter provided by the provider. Will return `nil` if the string couldn't be parsed
     */
    convenience init?(string: String, provider: DateFormatterProvider) {
        let formatter = NSDateFormatter.formatter(with: provider)
        self.init(string: string, formatter: formatter)
    }
}
