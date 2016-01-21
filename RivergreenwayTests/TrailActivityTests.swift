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
    
    var activity: TrailActivity?
    
    override func setUp() {
        super.setUp()
        let timeStamp = NSDate().timeIntervalSince1970
        activity = TrailActivity(timeStamp: timeStamp)
        
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
    
    func testTransitionState() {
        let state = TrailActivityState.STARTED
        
        activity!.transitionState(state)
        assert(activity!.state == state)
    }
    
    func testAddPathSegment() {
        let pathSegment = GMSMutablePath()
        
        for index in 0...4 {
            let coordinate = CLLocationCoordinate2D(latitude: Double(index), longitude: Double(index))
            pathSegment.addCoordinate(coordinate)
        }
        
        activity!.addSegment(pathSegment)
        assert(contains(activity.path, pathSegment))
    }
}

