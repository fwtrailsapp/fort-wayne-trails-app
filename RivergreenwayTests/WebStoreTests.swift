//
//  WebStoreTests.swift
//  Rivergreenway
//
//  Created by Jared P on 2/20/16.
//  Copyright © 2016 City of Fort Wayne Greenways and Trails Department. All rights reserved.
//

import XCTest
@testable import Rivergreenway

class WebStoreTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        WebStore.clearState()
    }
    
    func login(callback: () -> Void) {
        WebStore.login("iostest", password: "iostest",
            errorCallback: { error in
                XCTFail(error.description)
            },
            successCallback: {
                callback()
            }
        )
    }
    
    func testLogin() {
        let exp = expectationWithDescription("testLogin")
        login({
            XCTAssert(WebStore.hasAuthToken)
            exp.fulfill()
        })
        
        waitForExpectationsWithTimeout(5, handler: { error in
            XCTAssertNil(error, "Error")
        })
    }
    
    func testAccountCreate() {
        let exp = expectationWithDescription("testAccountCreate")
        let uuid = NSUUID().UUIDString
        let uuidSub = uuid.substringToIndex(uuid.startIndex.advancedBy(5))
        let acct = Account(username: "xcode\(uuidSub)", birthYear: 1994, height: 256, weight: 256, sex: Sex.Male)
        WebStore.createAccount(acct, password: "forreal",
            errorCallback: { error in
                XCTFail(error.description)
            },
            successCallback: {
                exp.fulfill()
            })
        
        waitForExpectationsWithTimeout(5, handler: { error in
            XCTAssertNil(error, "Error")
        })
    }
    
    func testAccountGet() {
        let exp = expectationWithDescription("testAccountGet")
        
        login({
            WebStore.getAccount(
                errorCallback: { error in
                    XCTFail(error.description)
                }, successCallback: { acct in
                    print("Got acct: \(acct)")
                    exp.fulfill()
                }
            )
        })
        
        waitForExpectationsWithTimeout(5, handler: { error in
            XCTAssertNil(error, "Error")
        })

    }
    
    func testCreateNewActivity() {
        let exp = expectationWithDescription("testCreateNewActivity")
        
        let activity = TestUtils.createTrailActivity()
        
        login({
            WebStore.createNewActivity(activity,
                errorCallback: { error in
                    XCTFail(error.description)
                },
                successCallback: {
                    exp.fulfill()
                }
            )
        })
        
        waitForExpectationsWithTimeout(5, handler: { error in
            XCTAssertNil(error, "Error")
        })
    }
    
    func testGetActivityHistory() {
        let exp = expectationWithDescription("testGetActivityHistory")
        
        login({
            WebStore.getActivityHistory(
                errorCallback: { error in
                    XCTFail()
                }, successCallback: { tahr in
                    print("We got \(tahr.activities.count) activities back from the server.")
                    exp.fulfill()
                }
            )
        })
        
        waitForExpectationsWithTimeout(5, handler: { error in
            XCTAssertNil(error, "Error")
        })
    }
    
    func testGetUserStatistics() {
        let exp = expectationWithDescription("testGetUserStatistics")
        
        login({
            WebStore.getUserStatistics(
                errorCallback: { error in
                    XCTFail()
                }, successCallback: { stats in
                    if stats.stats.count != 4 { //bike, walk, run, overall
                        print("\(stats.stats.count) out of 4 stat types gotten.")
                        XCTFail()
                    } else {
                        exp.fulfill()
                    }
                }
            )
        })
        
        waitForExpectationsWithTimeout(5, handler: { error in
            XCTAssertNil(error, "Error")
        })
    }
}
