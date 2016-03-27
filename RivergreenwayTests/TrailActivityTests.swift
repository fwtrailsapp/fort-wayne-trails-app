//
//  TestTrailActivity.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 1/16/16.
//  Copyright © 2016 City of Fort Wayne Greenways and Trails Department. All rights reserved.
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
        
        XCTAssertEqualWithAccuracy(basicActivity!.getDistance(), 1264 / 5280, accuracy: 0.05)
    }
    
    func testDuration() {
        let duration = emptyActivity!.getDuration()
        assert(duration == 0)
    }
    
    func testAverageSpeed() {
        let averageSpeed = emptyActivity!.getAverageSpeed()
        assert(averageSpeed == 0)
        XCTAssertEqualWithAccuracy(basicActivity!.getAverageSpeed(), 14.36364, accuracy: 0.05)
    }
    
    func initializeEmptyActivity() {
        let startTime = NSDate()
        let duration: Double = 0
        let exerciseType = ExerciseType.Run
        let caloriesBurned: Double = 0
        let path = [GMSMutablePath]()
        self.emptyActivity = TrailActivity(startTime: startTime, duration: duration, distance: 0, path: path, exerciseType: exerciseType, caloriesBurned: caloriesBurned)
    }
    
    func initializeBasicActivity() {
        let startTime = NSDate()
        let duration: Double = 60 // add a minute
        let exerciseType = ExerciseType.Run
        let caloriesBurned: Double = 1000
        let coord1 = CLLocationCoordinate2D(latitude: -85.189383,longitude: 40.9806756)
        let coord2 = CLLocationCoordinate2D(latitude: -85.1909924,longitude: 40.9795255)
        let coord3 = CLLocationCoordinate2D(latitude: -85.1926017,longitude: 40.9782133)
        var path = [GMSMutablePath]()
        let path1 = GMSMutablePath()
        path1.addCoordinate(coord1)
        path1.addCoordinate(coord2)
        path1.addCoordinate(coord3)
        path.append(path1)
        self.basicActivity = TrailActivity(startTime: startTime, duration: duration, distance: 1264/5280, path: path, exerciseType: exerciseType, caloriesBurned: caloriesBurned)
    }
}
