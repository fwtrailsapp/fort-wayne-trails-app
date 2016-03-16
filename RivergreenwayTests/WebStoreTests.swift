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
        
        let acct = Account(username: "xcodeisbad", birthYear: 1994, height: 256, weight: 256, sex: Sex.MALE)
        ws.accountCreate(acct, password: "forreal", errorCallback: { error in
                XCTFail(error.description)
            },
            successCallback: {
                exp.fulfill()
            })
        
        waitForExpectationsWithTimeout(5, handler: { error in
            XCTAssertNil(error, "Error")
        })
    }
    
    func testRegisterWithOptionals() {
        let exp = expectationWithDescription("testRegisterWithOptionals")
        
        let acct = Account(username: "ifyouchoosenottodecide")
        ws.accountCreate(acct, password: "youstillhavemadeachoice", errorCallback: { error in
            XCTFail(error.description)
        },
        successCallback: {
            exp.fulfill()
        })
        
        waitForExpectationsWithTimeout(5, handler: { error in
            XCTAssertNil(error, "Error")
        })
    }
    
    func testGetAccount() {
        let exp = expectationWithDescription("testGetAccount")
        
        ws.getAccount({ error in
            XCTFail(error.description)
        }, successCallback: { acctDeets in
            exp.fulfill() //TODO: check values
        })
        
        waitForExpectationsWithTimeout(5, handler: { error in
            XCTAssertNil(error, "Error")
        })
    }
}
