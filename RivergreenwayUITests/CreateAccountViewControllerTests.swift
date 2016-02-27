//
//  CreateAccountViewControllerTests.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 2/6/16.
//  Copyright © 2016 City of Fort Wayne Rivergreenways. All rights reserved.
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
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testUsernameFieldHittable() {
        app!.buttons["Create Account"].tap()
        assert(tablesQuery!.textFields["username"].hittable)
    }
    
    func testPasswordFieldHittable() {
        app!.buttons["Create Account"].tap()
        assert(tablesQuery!.textFields["password"].hittable)
    }
    
    func testPasswordConfirmFieldHittable() {
        app!.buttons["Create Account"].tap()
        assert(tablesQuery!.textFields["confirm password"].hittable)
    }
    
    func testHeightFieldHittable() {
        app!.buttons["Create Account"].tap()
        assert(tablesQuery!.textFields["height (inches)"].hittable)
    }
    
    func testWeightFieldHittable() {
        app!.buttons["Create Account"].tap()
        assert(tablesQuery!.textFields["weight (pounds)"].hittable)
    }
    
    func testBirthYearFieldHittable() {
        app!.buttons["Create Account"].tap()
        assert(app!.tables.textFields["birth year"].hittable)
        
    }
    
    func testGenderFieldHittable() {
        app!.buttons["Create Account"].tap()
        assert(app!.tables.buttons["NotInterested"].hittable)
    }
}
