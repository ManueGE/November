//
//  MGEDateFormatterTests.swift
//  MGEDateFormatterTests
//
//  Created by Manu on 16/6/16.
//  Copyright © 2016 manuege. All rights reserved.
//

import XCTest
@testable import MGEDateFormatter

class MGEDateFormatterTests: XCTestCase {
    
    let template = "ddMMMyyyyHHmm"
    
    let spanishLocale = NSLocale(localeIdentifier: "es")
    let date: NSDate = {
       
        let components = NSDateComponents()
        components.day = 18
        components.month = 11
        components.year = 1983
        components.hour = 11
        components.minute = 30
        return NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!.dateFromComponents(components)!
        
    }()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDateFormatConfigurator() {
        
        class MyConfigurator: DateFormatterConfiguration {
            let cacheKey: String
            let format: String
            
            init(format: String) {
                self.format = format
                self.cacheKey = "MyConfigurator(\(format))"
            }
            
            func configure(formatter: NSDateFormatter) {
                formatter.dateFormat = format
                formatter.monthSymbols = ["EN", "FB", "MZ", "AB", "MY", "JN", "JL", "AG", "SP", "OT", "NV", "DC"]
                formatter.shortWeekdaySymbols = ["D", "L", "M", "X", "J", "V", "S", "D"]
                formatter.weekdaySymbols = ["Dom", "Lun", "Mar", "Mie", "Jue", "Vie", "Sab"]
            }
        }
        
        let configurator = MyConfigurator(format: "dd MMMM yyyy hh:mm:ss")
        
        XCTAssertEqual(date.string(with: configurator), "18 NV 1983 11:30:00", "conversion failed")
        XCTAssertNil(NSDate(string: "", configurator: configurator), "date should be nil")
        XCTAssertEqualWithAccuracy(NSDate(string: "18 NV 1983 11:30:00", configurator: configurator)!.timeIntervalSince1970, date.timeIntervalSince1970, accuracy: 0.001, "conversion failed")
        
    }
    
    // MARK: Style
    func testDateToStringWithStyle() {
        let string = date.string(withDateStyle: .ShortStyle, timeStyle: .ShortStyle)
        XCTAssertEqual(string, "11/18/83, 11:30 AM", "conversion failed")
    }
    
    func testStringToDateWithStyle() {
        let string = "11/18/83, 11:30 AM"
        let convertedDate = NSDate(string: string, dateStyle: .ShortStyle, timeStyle: .ShortStyle)
        XCTAssertEqualWithAccuracy(convertedDate!.timeIntervalSince1970, date.timeIntervalSince1970, accuracy: 0.001, "conversion failed")
    }
    
    func testDateToStringWithLocalizedStyle() {
        let string = date.string(withDateStyle: .ShortStyle, timeStyle: .ShortStyle, locale: spanishLocale)
        XCTAssertEqual(string, "18/11/83 11:30", "conversion failed")
    }
    
    func testStringToDateWithLocalizedStyle() {
        let string = "18/11/83 11:30"
        let convertedDate = NSDate(string: string, dateStyle: .ShortStyle, timeStyle: .ShortStyle, locale: spanishLocale)
        XCTAssertEqualWithAccuracy(convertedDate!.timeIntervalSince1970, date.timeIntervalSince1970, accuracy: 0.001, "conversion failed")
    }
    
    // MARK: Template
    func testDateToStringWithTemplate() {
        let string = date.string(withTemplate: template)
        XCTAssertEqual(string, "Nov 18, 1983, 11:30", "conversion failed")
    }
    
    func testStringToDateWithTemplate() {
        let string = "Nov 18, 1983, 11:30"
         let convertedDate = NSDate(string: string, template: template)
        XCTAssertEqualWithAccuracy(convertedDate!.timeIntervalSince1970, date.timeIntervalSince1970, accuracy: 0.001, "conversion failed")
    }
    
    func testDateToStringWithLocalizedTemplate() {
        let string = date.string(withTemplate: template, locale: spanishLocale)
        XCTAssertEqual(string, "nov 18, 1983, 11:30", "conversion failed")
    }
    
    func testStringToDateWithLocalizedTemplate() {
        let string = "Nov 18, 1983, 11:30"
        let convertedDate = NSDate(string: string, template: template, locale: spanishLocale)
        XCTAssertEqualWithAccuracy(convertedDate!.timeIntervalSince1970, date.timeIntervalSince1970, accuracy: 0.001, "conversion failed")
    }
}
