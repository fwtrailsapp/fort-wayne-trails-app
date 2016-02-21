//
//  AccountTests.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 1/21/16.
//  Copyright © 2016 City of Fort Wayne Rivergreenways. All rights reserved.
//

import XCTest
@testable import Rivergreenway

class AccountTests: XCTestCase {
    
    var emptyAccount: Account?
    var scottAccount: Account?
    
    override func setUp() {
        super.setUp()
        
        let email = "test@email.com"
        emptyAccount = Account(email: email)
        let birthYear = 1994

        scottAccount = Account(email: "scott@email.com",
            birthYear: birthYear,
            height: 68,
            weight: 155,
            sex: Sex.MALE)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBMR() {
        let BMR = emptyAccount!.BMR()
        assert(BMR == nil)
        
        let scottBMR = scottAccount!.BMR()
        print(scottBMR!)
        print(scottAccount!.getAge()!)
        XCTAssertEqualWithAccuracy(scottBMR!, 1752.45, accuracy: 50.0)
    }
}
