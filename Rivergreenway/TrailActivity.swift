//
// Copyright (C) 2016 Jared Perry, Jaron Somers, Warren Barnes, Scott Weidenkopf, and Grant Grimm
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software
// and associated documentation files (the "Software"), to deal in the Software without restriction,
// including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in all copies
// or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
// LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
// WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH
// THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
//
//  TestTrailActivity.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 1/16/16.
//  Copyright © 2016 City of Fort Wayne Greenways and Trails Department. All rights reserved.
//

import Foundation
import JSONJoy

/**
 Represents a single activity on the trails.
 */
class TrailActivity : DictionarySerializable {
    
    private var startTime: NSDate // yyyy-MM-dd'T'HH:mm:ss
    private var duration: NSTimeInterval // seconds
    private var path: [GMSMutablePath]?
    private var exerciseType: ExerciseType
    private var caloriesBurned: Double // kCal
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
    
    /**
     DictionarySerializable function to represent this object as a dictionary of key:value pairs.
     */
    func toDictionary() -> [String: NSObject] {
        
        var dictionary: [String: NSObject] = [
            "time_started": Converter.dateToString(self.startTime),
            "duration": Converter.timeIntervalToString(self.duration),
            "mileage": self.distance,
            "calories_burned": Int(self.caloriesBurned),
            "exercise_type": self.exerciseType.rawValue]
        
        if let realPath = self.path {
            dictionary["path"] = Converter.pathsToString(realPath)
        } else {
            dictionary["path"] = NSNull()
        }
        
        return dictionary
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

