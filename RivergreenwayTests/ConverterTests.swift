//
// Copyright (C) 2016 Jared Perry, Jaron Somers, Warren Barnes, Scott Weidenkopf, and Grant Grimm
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software
// and associated documentation files (the "Software"), to deal in the Software without restriction,
// including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in all copies
// or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
// LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
// WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH
// THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
//
//  ConverterTests.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 1/23/16.
//  Copyright © 2016 City of Fort Wayne Greenways and Trails Department and Trails Department. All rights reserved.
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
    
    func testFeetToMeters() {
        let meters = Converter.feetToMeters(1)
        assert(meters == 0.3048)
    }
    
    func testMetersToFeet() {
        let feet = Converter.metersToFeet(1)
        assert(feet == 3.28084)
    }
    
    func testStringToTimeIntervalA() {
        let str = "00:00:03"
        let interval = Converter.stringToTimeInterval(str)
        XCTAssertNotNil(interval)
        XCTAssert(interval! == 3.0)
    }
    
    func testStringToTimeIntervalB() {
        let str = "00:00:03.1"
        let interval = Converter.stringToTimeInterval(str)
        XCTAssertNotNil(interval)
        XCTAssert(interval! == 3.1)
    }
    
    func testStringToTimeIntervalC() {
        let str = "1.02:03:04"
        let interval = Converter.stringToTimeInterval(str)
        XCTAssertNotNil(interval)
        XCTAssert(interval! == 93784.0)
    }
    
    func testStringToTimeIntervalD() {
        let str = "1.02:03:04.123"
        let interval = Converter.stringToTimeInterval(str)
        XCTAssertNotNil(interval)
        XCTAssert(interval! == 93784.123)
    }
    
    func testPathToString() {
        let activity = TestUtils.createTrailActivity()
        
        print(activity.toDictionary())
    }
}
