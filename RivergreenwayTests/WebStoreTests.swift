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
