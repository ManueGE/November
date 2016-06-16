//
//  MGEDateFormatter.swift
//  MGEDateFormatter
//
//  Created by Manu on 16/6/16.
//  Copyright © 2016 manuege. All rights reserved.
//

import Foundation

extension NSDateFormatter {
    
    private enum Configuration: DateFormatterProvider {
        
        case style(dateStyle: NSDateFormatterStyle, timeStyle: NSDateFormatterStyle)
        case template(String)
        case format(String)
        
        case localizedStyle(dateStyle: NSDateFormatterStyle, timeStyle: NSDateFormatterStyle, locale: NSLocale)
        case localizedTemplate(template: String, locale: NSLocale)
        case localizedFormat(format: String, locale: NSLocale)
        
        var cacheKey: String {
            switch self {
                
            case let .style(dateStyle, timeStyle):
                return "style(\(dateStyle.rawValue),\(timeStyle.rawValue))"
            case let .template(template):
                return "template(\(template))"
            case let .format(format):
                return "format(\(format))"
                
            case let .localizedStyle(dateStyle, timeStyle, locale):
                return "localizedStyle(\(dateStyle.rawValue),\(timeStyle.rawValue),\(locale.localeIdentifier))"
            case let .localizedTemplate(template, locale):
                return "localizedTemplate(\(template),\(locale.localeIdentifier))"
            case let .localizedFormat(format, locale):
                return "localizedFormat(\(format),\(locale.localeIdentifier))"
                
            }
        }
        
        func configure(formatter: NSDateFormatter) {
            switch self {
                
            case let .style(dateStyle, timeStyle):
                formatter.dateStyle = dateStyle
                formatter.timeStyle = timeStyle
            case let .template(template):
                formatter.setLocalizedDateFormatFromTemplate(template)
            case let .format(format):
                formatter.dateFormat = format
                
            case let .localizedStyle(dateStyle, timeStyle, locale):
                formatter.dateStyle = dateStyle
                formatter.timeStyle = timeStyle
                formatter.locale = locale
            case let .localizedTemplate(template, locale):
                formatter.setLocalizedDateFormatFromTemplate(template)
                formatter.locale = locale
            case let .localizedFormat(format, locale):
                formatter.dateFormat = format
                formatter.locale = locale
            }
        }
    }
}

extension NSDate {
    
    // MARK: Base
    
    private func string(with configuration: NSDateFormatter.Configuration) -> String {
        let formatter = NSDateFormatter.formatter(with: configuration)
        return formatter.stringFromDate(self)
    }
    
    private convenience init?(string: String, configuration: NSDateFormatter.Configuration) {
        let formatter = NSDateFormatter.formatter(with: configuration)
        guard let date = formatter.dateFromString(string) else { return nil }
        self.init(timeIntervalSinceNow: date.timeIntervalSinceNow)
    }
    
    // MARK: String from date
    
    func string(withDateStyle dateStyle: NSDateFormatterStyle, timeStyle: NSDateFormatterStyle, locale: NSLocale? = nil) -> String {
        if let locale = locale {
            return string(with: .localizedStyle(dateStyle: dateStyle, timeStyle: timeStyle, locale: locale))
        }
            
        else {
            return string(with: .style(dateStyle: dateStyle, timeStyle: timeStyle))
        }
    }
    
    func string(withTemplate template: String, locale: NSLocale? = nil) -> String {
        if let locale = locale {
            return string(with: .localizedTemplate(template: template, locale: locale))
        }
            
        else {
            return string(with: .template(template))
        }
    }
    
    func string(withFormat format: String, locale: NSLocale? = nil) -> String {
        if let locale = locale {
            return string(with: .localizedFormat(format: format, locale: locale))
        }
            
        else {
            return string(with: .format(format))
        }
    }
    
    // MARK: Date from string
    
    convenience init?(string: String, dateStyle: NSDateFormatterStyle, timeStyle: NSDateFormatterStyle, locale: NSLocale? = nil) {
        if let locale = locale {
            self.init(string: string, configuration: .localizedStyle(dateStyle: dateStyle, timeStyle: timeStyle, locale: locale))
        }
            
        else {
            self.init(string: string, configuration: .style(dateStyle: dateStyle, timeStyle: timeStyle))
        }
    }
    
    convenience init?(string: String, template: String, locale: NSLocale? = nil) {
        if let locale = locale {
            self.init(string: string, configuration: .localizedTemplate(template: template, locale: locale))
        }
            
        else {
            self.init(string: string, configuration: .template(template))
        }
    }
    
    convenience init?(string: String, format: String, locale: NSLocale? = nil) {
        if let locale = locale {
            self.init(string: string, configuration: .localizedFormat(format: format, locale: locale))
        }
            
        else {
            self.init(string: string, configuration: .format(format))
        }
    }
}
