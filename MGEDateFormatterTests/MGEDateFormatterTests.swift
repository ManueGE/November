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
}
