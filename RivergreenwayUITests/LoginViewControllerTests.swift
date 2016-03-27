//
//  LoginViewControllerTests.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 1/29/16.
//  Copyright © 2016 City of Fort Wayne Rivergreenways and Trails Department. All rights reserved.
//

import XCTest

class LoginViewControllerTests: XCTestCase {
    
    var app: XCUIApplication?
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        app = XCUIApplication()
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app!.launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLoginButton() {
        app!.buttons["Login"].tap()
        let barTitle = app!.navigationBars["Record Activity"].staticTexts["Record Activity"]
        assert(barTitle.hittable)
    }
    
    func testCreateButton() {
        app!.buttons["Create Account"].tap()
        let barTitle = app!.navigationBars["Create Account"].staticTexts["Create Account"]
        assert(barTitle.hittable)
    }
}
