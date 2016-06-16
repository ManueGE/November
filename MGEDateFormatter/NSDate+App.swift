//
//  NSDate+App.swift
//  MGEDateFormatter
//
//  Created by Manu on 16/6/16.
//  Copyright © 2016 manuege. All rights reserved.
//

import Foundation

extension NSDate {
    
    // The templates used in the app
    enum Template: String {
        case monthAndYear = "MMMyyyy"
        case fullShortDate = "ddMMyy"
    }
    
    // The format used in the app
    enum Format: String {
        case fullDate = "dd/MM/yyyy"
        case fullDateAndTime = "dd/MM/yyyy HH:mm:ss"
    }
    
    // MARK: Helpers Date -> String
    
    func string(with template: Template) -> String {
        return string(withTemplate: template.rawValue)
    }
    
    func string(with format: Format) -> String {
        return string(withFormat: format.rawValue)
    }
    
    // MARK: Helpers String -> Date
    
    convenience init?(string: String, template: Template) {
        self.init(string: string, template: template.rawValue)
    }
    
    convenience init?(string: String, format: Format) {
        self.init(string: string, format: format.rawValue)
    }
}

class MyDateFormatterProvider: DateFormatterProvider {
    let cacheKey: String
    let format: String
    
    init(format: String) {
        self.format = format
        self.cacheKey = "MyConfigurator(\(format))"
    }
    
    func configure(formatter: NSDateFormatter) {
        formatter.dateFormat = format
        formatter.monthSymbols = ["JN", "FB", "MR", "AP", "MY", "JN", "JL", "AG", "SP", "OT", "NV", "DC"]
        // whatever configuration you need
    }
}
