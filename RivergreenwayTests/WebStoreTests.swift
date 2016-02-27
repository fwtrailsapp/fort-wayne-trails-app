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
    var ws : WebStore?

    override func setUp() {
        super.setUp()
        ws = WebStore()
    }

    func testGoodLogin() {
        let exp = expectationWithDescription("testGoodLogin")
        
        ws!.login("jared", password: "correctpass", errorCallback: { error in
            XCTFail()
        }, successCallback: {
            if let auth = self.ws!.authToken {
                print("authtoken is \(auth)")
                exp.fulfill()
            } else {
                XCTFail()
            }
        })
        
        waitForExpectationsWithTimeout(5, handler: { error in
            XCTAssertNil(error, "Error")
        })
    }
    
    func testBadLogin() {
        let exp = expectationWithDescription("testBadLogin")
        
        ws!.login("jared", password: "wr0ngpass", errorCallback: { error in
            switch error {
            case .BadCredentials:
                exp.fulfill()
                return
            default:
                print(error.description)
                XCTFail()
                return
            }
        }, successCallback: {
            XCTFail()
        })
        
        waitForExpectationsWithTimeout(5, handler: { error in
            XCTAssertNil(error, "Error")
        })
    }
}