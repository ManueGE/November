//
//  DateFormatterConfigurator.swift
//  MGEDateFormatter
//
//  Created by Manu on 16/6/16.
//  Copyright © 2016 manuege. All rights reserved.
//

import Foundation

protocol DateFormatterConfiguration {
    var cacheKey: String { get }
    func configure(formatter: NSDateFormatter)
}

internal extension NSDateFormatter {
    
    private static var formatters: [String: NSDateFormatter] = [:]
    
    static func formatter(with configuration: DateFormatterConfiguration) -> NSDateFormatter {
        
        if let formatter = formatters[configuration.cacheKey] {
            return formatter
        }
        
        let formatter = NSDateFormatter()
        configuration.configure(formatter)
        formatters[configuration.cacheKey] = formatter
        return formatter
    }
}

extension NSDate {
    
    // MARK: String from date
    
    func string(with configurator: DateFormatterConfiguration) -> String {
        let formatter = NSDateFormatter.formatter(with: configurator)
        return formatter.stringFromDate(self)
    }
    
    // MARK: Date from string
    
    convenience init?(string: String, configurator: DateFormatterConfiguration) {
        let formatter = NSDateFormatter.formatter(with: configurator)
        guard let date = formatter.dateFromString(string) else { return nil }
        self.init(timeIntervalSinceNow: date.timeIntervalSinceNow)
    }
}
