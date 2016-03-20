//
//  TestTrailActivity.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 1/16/16.
//  Copyright © 2016 City of Fort Wayne Rivergreenways. All rights reserved.
//

import Foundation

class TrailActivity {
    
    private var startTime: NSDate
    private var duration: NSTimeInterval // seconds
    private var path: [GMSMutablePath]
    private var exerciseType: ExerciseType
    private var caloriesBurned: Double
    private var distance: Double // miles
    
    init(startTime: NSDate, duration: NSTimeInterval, distance: Double, path: [GMSMutablePath], exerciseType: ExerciseType, caloriesBurned: Double) {
        self.startTime = startTime
        self.duration = duration
        self.exerciseType = exerciseType
        self.caloriesBurned = caloriesBurned
        self.path = path
        self.distance = distance
    }
    
    // returns distance in miles
    func getDistance() -> Double {
        return distance
    }
    
    func getDuration() -> NSTimeInterval{
        return duration
    }
    
    func getCaloriesBurned() -> Double {
        return caloriesBurned
    }
    
    func getStartTime() -> NSDate {
        return startTime
    }
    
    func getExerciseType() -> ExerciseType {
        return exerciseType
    }
    
    func getPath() -> [GMSMutablePath] {
        return path
    }
    
    func getAverageSpeed() -> Double {
        let duration = getDuration() / 3600
        let distance = getDistance()
        return (duration == 0) ? distance : distance / duration
    }
}

