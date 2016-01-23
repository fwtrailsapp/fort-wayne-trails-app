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
    
    var emptyActivity: TrailActivity?
    var basicActivity: TrailActivity?
    
    override func setUp() {
        super.setUp()
        
        // initialize empty activity
        initializeEmptyActivity()
        
        // initialize basic activity
        initializeBasicActivity()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDistance() {
        let distanceTraveled = emptyActivity!.getDistance()
        assert(distanceTraveled == 0)
    }
    
    func testDuration() {
        let duration = emptyActivity!.getDuration()
        assert(duration == 0)
    }
    
    func testAverageSpeed() {
        let averageSpeed = emptyActivity!.getAverageSpeed()
        assert(averageSpeed == 0)
    }
    
    func initializeEmptyActivity() {
        let startTime = NSDate().timeIntervalSince1970 * 1000
        let endTime = startTime
        let exerciseType = ExerciseType.RUNNING
        let caloriesBurned: Double = 0
        let path = [GMSMutablePath]()
        let topSpeed: Double = 0
        self.emptyActivity = TrailActivity(startTime: startTime, endTime: endTime, topSpeed: topSpeed, path: path, exerciseType: exerciseType, caloriesBurned: caloriesBurned)
    }
    
    func initializeBasicActivity() {
        let startTime = NSDate().timeIntervalSince1970 * 1000
        let endTime = startTime + 60000 // add a minute
        let exerciseType = ExerciseType.RUNNING
        let caloriesBurned: Double = 1000
        let path = [GMSMutablePath]()
        let topSpeed: Double = 10
        self.basicActivity = TrailActivity(startTime: startTime, endTime: endTime, topSpeed: topSpeed, path: path, exerciseType: exerciseType, caloriesBurned: caloriesBurned)
    }
}