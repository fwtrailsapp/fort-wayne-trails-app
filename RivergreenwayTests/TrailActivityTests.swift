//
//  TestTrailActivity.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 1/16/16.
//  Copyright © 2016 City of Fort Wayne Rivergreenways. All rights reserved.
//

import XCTest
@testable import Rivergreenway

class TrailActivityTests : XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testConstructor() {
        let timeStamp = NSDate().timeIntervalSince1970
        let activity = TrailActivity(timeStamp: timeStamp)
        
        assert(activity.timeStamp == timeStamp)
        assert(activity.state == TrailActivityState.CREATED)
    }
}

