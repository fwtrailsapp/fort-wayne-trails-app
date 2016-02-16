//
//  NavDrawerTableViewControllerTests.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 2/15/16.
//  Copyright © 2016 City of Fort Wayne Rivergreenways. All rights reserved.
//

import XCTest

class NavDrawerTableViewControllerTests: XCTestCase {
    
    var app: XCUIApplication?
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        app = XCUIApplication()
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        app!.buttons["Login"].tap()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSealDisplayed() {
        app!.navigationBars["Record Activity"].buttons["Menu"].tap()
        assert(app!.childrenMatchingType(.Window).elementBoundByIndex(0).childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.hittable)
        
    }
    
    func testRecordActivityNavigation() {
        app!.navigationBars["Record Activity"].buttons["Menu"].tap()
        app!.tables.cells.containingType(.StaticText, identifier:"Record Activity").childrenMatchingType(.StaticText).matchingIdentifier("Record Activity").elementBoundByIndex(0).tap()
        assert(app!.navigationBars["Record Activity"].staticTexts["Record Activity"].hittable)
    }
    
    func testActivityHistoryNavigation() {
        app!.navigationBars["Record Activity"].buttons["Menu"].tap()
        app!.tables.cells.containingType(.StaticText, identifier:"Activity History").childrenMatchingType(.StaticText).matchingIdentifier("Activity History").elementBoundByIndex(0).tap()
        assert(app!.navigationBars["Activity History"].staticTexts["Activity History"].hittable)
        
    }
    
    func testAchievementNavigation() {
        app!.navigationBars["Record Activity"].buttons["Menu"].tap()
        app!.tables.staticTexts["Achievements"].tap()
        assert(app!.navigationBars["Achievements"].staticTexts["Achievements"].hittable)
    }
    
    func testTrailMapNavigation() {
        app!.navigationBars["Record Activity"].buttons["Menu"].tap()
        app!.tables.cells.containingType(.StaticText, identifier:"Trail Map").childrenMatchingType(.StaticText).matchingIdentifier("Trail Map").elementBoundByIndex(0).tap()
        assert(app!.navigationBars["Trail Map"].staticTexts["Trail Map"].hittable)
    }
    
    func testAccountStatisticsNavigation() {
        app!.navigationBars["Record Activity"].buttons["Menu"].tap()
        XCUIApplication().tables.cells.containingType(.StaticText, identifier:"Account Statistics").childrenMatchingType(.StaticText).matchingIdentifier("Account Statistics").elementBoundByIndex(0).tap()
        
    }
}
