//
//  NovemberTests.swift
//  NovemberTests
//
//  Created by Manu on 16/6/16.
//  Copyright © 2016 manuege. All rights reserved.
//

import XCTest
@testable import November

class MyConfigurator: DateFormatterProvider {
    let cacheKey: String
    let format: String
    
    init(format: String) {
        self.format = format
        self.cacheKey = "MyConfigurator(\(format))"
    }
    
    func configure(_ formatter: DateFormatter) {
        formatter.dateFormat = format
        formatter.monthSymbols = ["EN", "FB", "MZ", "AB", "MY", "JN", "JL", "AG", "SP", "OT", "NV", "DC"]
        formatter.shortWeekdaySymbols = ["D", "L", "M", "X", "J", "V", "S", "D"]
        formatter.weekdaySymbols = ["Dom", "Lun", "Mar", "Mie", "Jue", "Vie", "Sab"]
    }
}

class NovemberTests: XCTestCase {
    
    let configurator = MyConfigurator(format: "dd MMMM yyyy hh:mm:ss")
    let template = "ddMMMMyyyyHHmm"
    let format = "dd/MMMM/yyyy HH:mm"
    
    let spanishLocale = Locale(identifier: "es")
    let date: Date = {
       
        var components = DateComponents()
        components.day = 18
        components.month = 11
        components.year = 1983
        components.hour = 11
        components.minute = 30
        return Calendar(identifier: .gregorian).date(from: components)!
        
    }()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: Configurator
    func testDateToStringWithConfigurator() {
        let string = date.string(with: configurator)
        XCTAssertEqual(string, "18 NV 1983 11:30:00", "conversion failed")
    }
    
    func testStringToDateWithConfigurator() {
        let string = "18 NV 1983 11:30:00"
        let convertedDate = Date(string: string, provider: configurator)!
        XCTAssertEqualWithAccuracy(convertedDate.timeIntervalSince1970, date.timeIntervalSince1970, accuracy: 0.001, "conversion failed")
    }
    
    func testStringToDateFailWithConfigurator() {
        let string = ""
        let convertedDate = Date(string: string, provider: configurator)
         XCTAssertNil(convertedDate, "date should be nil")
    }
    
    // MARK: Style
    func testDateToStringWithStyle() {
        let string = date.string(dateStyle: .short, timeStyle: .short)
        XCTAssertEqual(string, "11/18/83, 11:30 AM", "conversion failed")
    }
    
    func testStringToDateWithStyle() {
        let string = "11/18/83, 11:30 AM"
        let convertedDate = Date(string: string, dateStyle: .short, timeStyle: .short)!
        XCTAssertEqualWithAccuracy(convertedDate.timeIntervalSince1970, date.timeIntervalSince1970, accuracy: 0.001, "conversion failed")
    }
    
    func testDateToStringWithLocalizedStyle() {
        let string = date.string(dateStyle: .short, timeStyle: .short, locale: spanishLocale)
        XCTAssertEqual(string, "18/11/83 11:30", "conversion failed")
    }
    
    func testStringToDateWithLocalizedStyle() {
        let string = "18/11/83 11:30"
        let convertedDate = Date(string: string, dateStyle: .short, timeStyle: .short, locale: spanishLocale)!
        XCTAssertEqualWithAccuracy(convertedDate.timeIntervalSince1970, date.timeIntervalSince1970, accuracy: 0.001, "conversion failed")
    }
    
    // MARK: Template
    func testDateToStringWithTemplate() {
        let string = date.string(withTemplate: template)
        XCTAssertEqual(string, "November 18, 1983, 11:30", "conversion failed")
    }
    
    func testStringToDateWithTemplate() {
        let string = "November 18, 1983, 11:30"
        let convertedDate = Date(string: string, template: template)!
        XCTAssertEqualWithAccuracy(convertedDate.timeIntervalSince1970, date.timeIntervalSince1970, accuracy: 0.001, "conversion failed")
    }
    
    func testDateToStringWithLocalizedTemplate() {
        let string = date.string(withTemplate: template, locale: spanishLocale)
        XCTAssertEqual(string, "noviembre 18, 1983, 11:30", "conversion failed")
    }
    
    func testStringToDateWithLocalizedTemplate() {
        let string = "noviembre 18, 1983, 11:30"
        let convertedDate = Date(string: string, template: template, locale: spanishLocale)!
        XCTAssertEqualWithAccuracy(convertedDate.timeIntervalSince1970, date.timeIntervalSince1970, accuracy: 0.001, "conversion failed")
    }
    
    // MARK: Format
    func testDateToStringWithFormat() {
        let string = date.string(withFormat: format)
        XCTAssertEqual(string, "18/November/1983 11:30", "conversion failed")
    }
    
    func testStringToDateWithFormat() {
        let string = "18/November/1983 11:30"
        let convertedDate = Date(string: string, format: format)!
        XCTAssertEqualWithAccuracy(convertedDate.timeIntervalSince1970, date.timeIntervalSince1970, accuracy: 0.001, "conversion failed")
    }
    
    func testDateToStringWithLocalizedFormat() {
        let string = date.string(withFormat: format, locale: spanishLocale)
        XCTAssertEqual(string, "18/noviembre/1983 11:30", "conversion failed")
    }
    
    func testStringToDateWithLocalizedFormat() {
        let string = "18/noviembre/1983 11:30"
        let convertedDate = Date(string: string, format: format, locale: spanishLocale)!
        XCTAssertEqualWithAccuracy(convertedDate.timeIntervalSince1970, date.timeIntervalSince1970, accuracy: 0.001, "conversion failed")
    }
    
    // Fail test
    func testStringToDateFailWithFormat() {
        let string = ""
        let convertedDate = Date(string: string, format: format)
        XCTAssertNil(convertedDate, "")
    }
}
