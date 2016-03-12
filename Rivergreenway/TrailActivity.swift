//
//  TestTrailActivity.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 1/16/16.
//  Copyright © 2016 City of Fort Wayne Rivergreenways. All rights reserved.
//

import Foundation

class TrailActivity {
    
    private var startTime: NSTimeInterval
    private var duration: NSTimeInterval
    private var path: [GMSMutablePath]
    private var exerciseType: ExerciseType
    private var caloriesBurned: Double
    
    init(startTime: NSTimeInterval, duration: NSTimeInterval, path: [GMSMutablePath], exerciseType: ExerciseType, caloriesBurned: Double) {
        self.startTime = startTime
        self.duration = duration
        self.exerciseType = exerciseType
        self.caloriesBurned = caloriesBurned
        self.path = path
    }
    
    func getDistance() -> Double {
        var distance:Double = 0
        
        for segment in path {
            distance += Converter.metersToFeet(segment.lengthOfKind(kGMSLengthGeodesic))
        }
        return distance
    }
    
    func getDuration() -> NSTimeInterval{
        return duration
    }
    
    func getCaloriesBurned() -> Double {
        return caloriesBurned
    }
    
    func getStartTime() -> NSTimeInterval {
        return startTime
    }
    
    func getExerciseType() -> ExerciseType {
        return exerciseType
    }
    
    func getPath() -> [GMSMutablePath] {
        return path
    }
    
    func getAverageSpeed() -> Double {
        let duration = getDuration()
        let distance = getDistance()
        return (duration == 0) ? distance : distance / duration
    }
}

