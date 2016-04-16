//
//  AccountTests.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 1/21/16.
//  Copyright © 2016 City of Fort Wayne Greenways and Trails Department. All rights reserved.
//

import XCTest
@testable import Rivergreenway
import JSONJoy

class AccountTests: XCTestCase {
    
    var emptyAccount: Account?
    var scottAccount: Account?
    
    override func setUp() {
        super.setUp()
        
        let username = "test"
        emptyAccount = Account(username: username)
        let birthYear = 1994

        scottAccount = Account(username: "scott",
            birthYear: birthYear,
            height: 68,
            weight: 155,
            sex: Sex.Male)
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
        XCTAssertEqualWithAccuracy(scottBMR!, 1683, accuracy: 50.0)
    }
    
    //try to encode account as JSON then immediately decode it back
    func testSerialize() {
        let dec = JSONDecoder(emptyAccount!.toDictionary())
        if dec["sex"].rawValue! as! NSObject != NSNull() {
            XCTFail()
        }
        let acctBack = try! Account(dec, username: emptyAccount!.username)
        XCTAssertEqual(emptyAccount!.username, acctBack.username)
        XCTAssertEqual(emptyAccount!.birthYear, acctBack.birthYear)
        XCTAssertEqual(emptyAccount!.weight, acctBack.weight)
        XCTAssertEqual(emptyAccount!.sex, acctBack.sex)
        XCTAssertEqual(emptyAccount!.height, acctBack.height)
    }
}
