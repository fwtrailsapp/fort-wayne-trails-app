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
