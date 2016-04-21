//
//  TestUtils.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 4/13/16.
//  Copyright © 2016 City of Fort Wayne Greenways and Trails Department. All rights reserved.
//

import Foundation
@testable import Rivergreenway

class TestUtils {
    
    class func createTrailActivity() -> TrailActivity {
        let startTime = NSDate()
        let duration = 20.0
        let distance = 1337.0
        let path = createMutablePaths()
        let exerciseType = ExerciseType.Bike
        let caloriesBurned = 10.0
        return TrailActivity(startTime: startTime, duration: duration, distance: distance, path: path, exerciseType: exerciseType, caloriesBurned: caloriesBurned)
    }
    
    class func createMutablePaths() -> [GMSMutablePath] {
        let firstPath = GMSMutablePath()
        firstPath.addCoordinate(CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0))
        firstPath.addCoordinate(CLLocationCoordinate2D(latitude: 0.1, longitude: 0.1))
        
        let secondPath = GMSMutablePath()
        secondPath.addCoordinate(CLLocationCoordinate2D(latitude: 0.2, longitude: 0.2))
        secondPath.addCoordinate(CLLocationCoordinate2D(latitude: 0.3, longitude: 0.3))
        
        var manyPaths = [GMSMutablePath]()
        manyPaths.append(firstPath)
        manyPaths.append(secondPath)
        
        return manyPaths
    }
}