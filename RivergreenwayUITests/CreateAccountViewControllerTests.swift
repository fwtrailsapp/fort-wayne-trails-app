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
//  CreateAccountViewControllerTests.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 2/6/16.
//  Copyright © 2016 City of Fort Wayne Greenways and Trails Department. All rights reserved.
//

import XCTest

class CreateAccountViewControllerTests: XCTestCase {
    
    var app: XCUIApplication?
    var tablesQuery: XCUIElementQuery?
    
    override func setUp() {
        super.setUp()
       
        // Put setup code here. This method is called before the invocation of each test method in the class.
        app = XCUIApplication()
        tablesQuery = app!.tables
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        app!.buttons["Create Account"].tap()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testUsernameFieldHittable() {
        assert(app!.tables.textFields["username"].hittable)
    }
    
    func testPasswordFieldHittable() {
        assert(app!.tables.textFields["password"].hittable)
    }
    
    func testPasswordConfirmFieldHittable() {
        assert(app!.tables.textFields["confirm password"].hittable)        
    }
    
    func testHeightFieldHittable() {
        assert(app!.tables.textFields["height (inches)"].hittable)
        
    }
    
    func testWeightFieldHittable() {
        assert(app!.tables.textFields["weight (pounds)"].hittable)
    }
    
    func testBirthYearFieldHittable() {
        assert(app!.tables.textFields["birth year"].hittable)
        
    }
    
    func testGenderFieldHittable() {
        assert(app!.tables.buttons["NotInterested"].hittable)
    }
}
