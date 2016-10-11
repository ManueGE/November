//
//  DateFormatter+Configuration.swift
//  November
//
//  Created by Manu on 16/6/16.
//  Copyright © 2016 manuege. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    /**
     Enum that implement the `DateFormatterProvider` protocol. Each case is used to adjust some properties of the `DateFormatter`
     */
    fileprivate enum Configuration: DateFormatterProvider {
        
        case style(dateStyle: Style, timeStyle: Style)
        case template(String)
        case format(String)
        
        case localizedStyle(dateStyle: Style, timeStyle: Style, locale: Locale)
        case localizedTemplate(template: String, locale: Locale)
        case localizedFormat(format: String, locale: Locale)
        
        var cacheKey: String {
            switch self {
                
            case let .style(dateStyle, timeStyle):
                return "style(\(dateStyle.rawValue),\(timeStyle.rawValue))"
            case let .template(template):
                return "template(\(template))"
            case let .format(format):
                return "format(\(format))"
                
            case let .localizedStyle(dateStyle, timeStyle, locale):
                return "localizedStyle(\(dateStyle.rawValue),\(timeStyle.rawValue),\(locale.identifier))"
            case let .localizedTemplate(template, locale):
                return "localizedTemplate(\(template),\(locale.identifier))"
            case let .localizedFormat(format, locale):
                return "localizedFormat(\(format),\(locale.identifier))"
                
            }
        }
        
        func configure(_ formatter: DateFormatter) {
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

public extension Date {
    
    // MARK: Base
    private func string(with configuration: DateFormatter.Configuration) -> String {
        let formatter = DateFormatter.formatter(with: configuration)
        return formatter.string(from: self)
    }
    
    private init?(string: String, configuration: DateFormatter.Configuration) {
        let formatter = DateFormatter.formatter(with: configuration)
        self.init(string: string, formatter: formatter)
    }
    
    // MARK: String from date
    
    /**
     Returns a string representation for a given date using the given dateStyle, timeStyle and locale
     - parameter dateStlye: The style used to convert the date
     - parameter timeStyle: The style used to convert the time
     - parameter locale: The locale used to perform the conversion. Default is `nil`, so the default location for `DateFormatter` will be used
     - returns: the string representation for the date using the given dateStyle, timeStyle and locale
     */
    public func string(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style, locale: Locale? = nil) -> String {
        if let locale = locale {
            return string(with: .localizedStyle(dateStyle: dateStyle, timeStyle: timeStyle, locale: locale))
        }
            
        else {
            return string(with: .style(dateStyle: dateStyle, timeStyle: timeStyle))
        }
    }
    
    /**
     Returns a string representation for a given date using the given template and locale
     - parameter template: The date format from a template using the specified locale
     - parameter locale: The locale used to perform the conversion. Default is `nil`, so the default location for `DateFormatter` will be used
     - returns: the string representation for the date using the given template and locale
     */
    public func string(withTemplate template: String, locale: Locale? = nil) -> String {
        if let locale = locale {
            return string(with: .localizedTemplate(template: template, locale: locale))
        }
            
        else {
            return string(with: .template(template))
        }
    }
    
    /**
     Returns a string representation for a given date using the given format and locale
     - parameter format: The date format used to convert the date
     - parameter locale: The locale used to perform the conversion. Default is `nil`, so the default location for `DateFormatter` will be used
     - returns: the string representation for the date using the given format and locale
     */
    public func string(withFormat format: String, locale: Locale? = nil) -> String {
        if let locale = locale {
            return string(with: .localizedFormat(format: format, locale: locale))
        }
            
        else {
            return string(with: .format(format))
        }
    }
    
    // MARK: Date from string
    
    /**
     Returns a date instantiated with the given dateStyle, timeStyle and locale
     - parameter dateStlye: The style used to convert the date
     - parameter timeStyle: The style used to convert the time
     - parameter locale: The locale used to perform the conversion. Default is `nil`, so the default location for `DateFormatter` will be used
     - returns: the date instantiated with the given dateStyle, timeStyle and locale. Will return `nil` if the string couldn't be parsed
     */
    public init?(string: String, dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style, locale: Locale? = nil) {
        if let locale = locale {
            self.init(string: string, configuration: .localizedStyle(dateStyle: dateStyle, timeStyle: timeStyle, locale: locale))
        }
            
        else {
            self.init(string: string, configuration: .style(dateStyle: dateStyle, timeStyle: timeStyle))
        }
    }
    
    /**
     Returns a date instantiated with the given template and locale
     - parameter template: The date format from a template using the specified locale
     - parameter locale: The locale used to perform the conversion. Default is `nil`, so the default location for `DateFormatter` will be used
     - returns: the date instantiated with the given template and locale. Will return `nil` if the string couldn't be parsed
     */
    public init?(string: String, template: String, locale: Locale? = nil) {
        if let locale = locale {
            self.init(string: string, configuration: .localizedTemplate(template: template, locale: locale))
        }
            
        else {
            self.init(string: string, configuration: .template(template))
        }
    }
    
    /**
     Returns a date instantiated with the given format and locale
     - parameter format: The date format used to convert the date
     - parameter locale: The locale used to perform the conversion. Default is `nil`, so the default location for `DateFormatter` will be used
     - returns: the date instantiated with the given format and locale. Will return `nil` if the string couldn't be parsed
     */
    public init?(string: String, format: String, locale: Locale? = nil) {
        if let locale = locale {
            self.init(string: string, configuration: .localizedFormat(format: format, locale: locale))
        }
            
        else {
            self.init(string: string, configuration: .format(format))
        }
    }
}
