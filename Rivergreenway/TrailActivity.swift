//
//  TestTrailActivity.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 1/16/16.
//  Copyright © 2016 City of Fort Wayne Rivergreenways. All rights reserved.
//

import Foundation

class TrailActivity {
    
    var startTime: NSTimeInterval
    var endTime: NSTimeInterval
    var path: [GMSMutablePath]
    var topSpeed: Double?
    var exerciseType: ExerciseType
    var caloriesBurned: Double
    
    init(startTime: NSTimeInterval, endTime: NSTimeInterval, topSpeed: Double, path: [GMSMutablePath], exerciseType: ExerciseType, caloriesBurned: Double) {
        self.startTime = startTime
        self.endTime = endTime
        self.exerciseType = exerciseType
        self.caloriesBurned = caloriesBurned
        self.path = path
        self.topSpeed = topSpeed
    }
    
    func getDistance() -> Double {
        var distance:Double = 0
        
        for segment in path {
            distance += Converter.metersToFeet(segment.lengthOfKind(kGMSLengthGeodesic))
        }
        return distance
    }
    
    func getDuration() -> NSTimeInterval{
        return Converter.millisecondsToHours(endTime - startTime)
        
    }
    
    func getAverageSpeed() -> Double {
        let duration = getDuration()
        let distance = getDistance()
        return (duration == 0) ? distance : distance / duration
    }
}

