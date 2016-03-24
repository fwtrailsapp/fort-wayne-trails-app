//
//  TestTrailActivity.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 1/16/16.
//  Copyright © 2016 City of Fort Wayne Rivergreenways. All rights reserved.
//

import Foundation
import JSONJoy

class TrailActivity {
    
    private var startTime: NSDate
    private var duration: NSTimeInterval // seconds
    private var path: [GMSMutablePath]?
    private var exerciseType: ExerciseType
    private var caloriesBurned: Double
    private var distance: Double // miles
    
    init(startTime: NSDate, duration: NSTimeInterval, distance: Double, path: [GMSMutablePath]? = nil, exerciseType: ExerciseType, caloriesBurned: Double) {
        self.startTime = startTime
        self.duration = duration
        self.exerciseType = exerciseType
        self.caloriesBurned = caloriesBurned
        self.path = path
        self.distance = distance
    }
    
    init(_ decoder: JSONDecoder) throws {
        let uTimeStarted: String = try decoder["time_started"].getString()
        let uDuration: String = try decoder["duration"].getString()
        let uExType: String = try decoder["exercise_type"].getString()
        let uCalories: Double = try decoder["calories_burned"].getDouble()
        let uMileage: Double = try decoder["mileage"].getDouble()
        
        let oStartTime: NSDate? = Converter.stringToDate(uTimeStarted)
        let oDuration: NSTimeInterval? = Converter.stringToTimeInterval(uDuration)
        let oExType: ExerciseType? = ExerciseType.fromStringIgnoreCase(uExType)
        let oCalories: Double? = uCalories
        let oMileage: Double? = uMileage
        
        if oStartTime == nil || oDuration == nil || oExType == nil || oCalories == nil || oMileage == nil {
            throw JSONError.WrongType
        }
        
        self.startTime = oStartTime!
        self.duration = oDuration!
        self.exerciseType = oExType!
        self.caloriesBurned = oCalories!
        self.distance = oMileage!
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
    
    func getPath() -> [GMSMutablePath]? {
        return path
    }
    
    func getAverageSpeed() -> Double {
        let duration = getDuration() / 3600
        let distance = getDistance()
        return (duration == 0) ? distance : distance / duration
    }
}

