//
//  ConverterTests.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 1/23/16.
//  Copyright © 2016 City of Fort Wayne Rivergreenways. All rights reserved.
//

import XCTest
@testable import Rivergreenway

class ConverterTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPoundsToKilograms() {
        let kilograms = Converter.poundsToKilograms(1)
        assert(kilograms == 0.453592)
    }
    
    func testInchesToCentimeters() {
        let centimeters = Converter.inchesToCentimeters(1)
        print(centimeters)
        assert(centimeters == 2.54)
    }
    
    func testMillisecondsToHours() {
        let hours = Converter.millisecondsToHours(1)
        assert(hours == 1 / 3600000)
    }
    
    func testHoursToMilliseconds() {
        let milliseconds = Converter.hoursToMilliseconds(1)
        assert(milliseconds == 3600000)
    }
    
    func testFeetToMeters() {
        let meters = Converter.feetToMeters(1)
        assert(meters == 0.3048)
    }
    
    func testMetersToFeet() {
        let feet = Converter.metersToFeet(1)
        assert(feet == 3.28084)
    }
}