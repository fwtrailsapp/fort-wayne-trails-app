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

    func testLogin() {
        do {
            try ws!.login("good", password: "yes")
        } catch (WebStore.WebStoreError.BadCredentials) {
            XCTFail("Should have logged in")
        } catch {
            XCTFail("Wrong type of exception")
        }
    }
}
