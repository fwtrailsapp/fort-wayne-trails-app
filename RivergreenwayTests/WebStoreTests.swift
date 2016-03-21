//
//  WebStoreTests.swift
//  Rivergreenway
//
//  Created by Jared P on 2/20/16.
//  Copyright © 2016 City of Fort Wayne Rivergreenways. All rights reserved.
//

import XCTest
@testable import Rivergreenway

class WebStoreTests: XCTestCase {
    var ws : WebStore!

    override func setUp() {
        super.setUp()
        ws = WebStore()
    }
    
    func testAccountCreate() {
        let exp = expectationWithDescription("testAccountCreate")
        let uuid = NSUUID().UUIDString
        let acct = Account(username: "xcodeisbad\(uuid)", birthYear: 1994, height: 256, weight: 256, sex: Sex.MALE)
        ws.createAccount(acct, password: "forreal", errorCallback: { error in
                XCTFail(error.description)
            },
            successCallback: {
                exp.fulfill()
            })
        
        waitForExpectationsWithTimeout(5, handler: { error in
            XCTAssertNil(error, "Error")
        })
    }
    
    func testAccountCreateMinimal() {
        let exp = expectationWithDescription("testAccountCreateMinimal")
        let uuid = NSUUID().UUIDString
        let acct = Account(username: "ifyouchoosenottodecide\(uuid)")
        ws.createAccount(acct, password: "youstillhavemadeachoice", errorCallback: { error in
            XCTFail(error.description)
        },
        successCallback: {
            exp.fulfill()
        })
        
        waitForExpectationsWithTimeout(5, handler: { error in
            XCTAssertNil(error, "Error")
        })
    }
    
    func testCreateNewActivity() {
        let exp = expectationWithDescription("testCreateNewActivity")
        
        let username = "ggrimm"
        let activity = createTrailActivity()
        ws.createNewActivity(username, act: activity, errorCallback: { error in
            XCTFail(error.description)
        },
        successCallback: {
            exp.fulfill()
        })
        
        waitForExpectationsWithTimeout(5, handler: { error in
            XCTAssertNil(error, "Error")
        })
    }
    
    private func createTrailActivity() -> TrailActivity {
        let startTime = NSDate()
        let duration = 20.0
        let distance = 1337.0
        let path = createMutablePaths()
        let exerciseType = ExerciseType.Bike
        let caloriesBurned = 10.0
        return TrailActivity(startTime: startTime, duration: duration, distance: distance, path: path, exerciseType: exerciseType, caloriesBurned: caloriesBurned)
    }
    
    private func createMutablePaths() -> [GMSMutablePath] {
        let firstPath = GMSMutablePath()
        firstPath.addCoordinate(CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0))
        firstPath.addCoordinate(CLLocationCoordinate2D(latitude: 0.1, longitude: 0.1))
        
        let secondPath = GMSMutablePath()
        secondPath.addCoordinate(CLLocationCoordinate2D(latitude: 0.2, longitude: 0.2))
        secondPath.addCoordinate(CLLocationCoordinate2D(latitude: 0.3, longitude: 0.3))
        
        var manyPaths = [GMSMutablePath]()
        manyPaths.append(firstPath)
        manyPaths.append(secondPath)
        
        return manyPaths
    }
}
