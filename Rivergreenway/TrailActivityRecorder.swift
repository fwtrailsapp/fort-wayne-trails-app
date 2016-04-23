//
//  TrailActivityRecorder.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 1/29/16.
//  Copyright © 2016 City of Fort Wayne Greenways and Trails Department. All rights reserved.
//

import Foundation

/**
 
 This beast[sic] of a class maintains the state of an activity as it is being recorded. For
 persisting a completed activity, use this class's getActivity() method to return a TrailActivity
 object.
 
 The recorder has a TrailActivityState field, which follows a well-defined control flow:
 
                           Stopped
                             ^
                             |
     Created -> Started -> Paused -> Resumed
                             ^         |
                             |         |
                             +---------+
 
 Each of the transitions in the control flow has its own method (e.g. start()).
 
 The motivation for creating this class is simple. There is a significant amount of functionality
 required to maintain activity information while a user records that activity: behaviors for
 controlling the state of the activity (e.g. pausing), incrementing values, etc. This functionality
 doesn't really fit well in the RecordActivityViewController: view controllers are meant to control
 views, as their name suggests, and their functionality should be limited to that role as much as
 possible. It also does not fit well in the TrailActivity class either: that class is meant as a
 model of trail activities: it is meant to store data in such a way the same class can easily be
 used to send data to and from the server and to be represented visually in views. TrailActivity seems
 to make more sense as an immutable object rather than as an object that is meant to be continuously
 updated. With those two points in mind, the TrailActivityRecorder class was born.
 
 */
class TrailActivityRecorder {
    
    private let AVERAGE_BMR: Double = 1577.5
    
    private var state: TrailActivityState = .Created
    private var exerciseType: ExerciseType
    private var BMR: Double
    
    // array of GMSMutablePaths (if a user pauses their recording,
    // a new path is created).
    private var path: [GMSMutablePath]
    
    // The current GMSMutablePath that the user is adding their locations to.
    private var segment: GMSMutablePath
    
    private var startTime: NSDate
    private var currLocation: CLLocation?
    private var lastLocation: CLLocation?
    private var distance: CLLocationDistance = 0
    private var duration: NSTimeInterval = 0
    private var calories: Double = 0
    
    init(startTime: NSDate, exerciseType: ExerciseType, BMR: Double? = nil) {
        path = [GMSMutablePath]()
        segment = GMSMutablePath()
        self.exerciseType = exerciseType
        self.startTime = startTime
        
        if BMR == nil {
            self.BMR = AVERAGE_BMR
        } else {
            self.BMR = BMR!
        }
    }
    
    /**
     Takes the current state of the recording's fields and creates a TrailActivity object.
     */
    func getActivity() -> TrailActivity {
        return TrailActivity(startTime: startTime, duration: duration, distance: distance, path: path, exerciseType: exerciseType, caloriesBurned: calories)
    }
    
    /**
     Returns the TrailActivityState of this object (e.g. Resumed).
     */
    func getState() -> TrailActivityState {
        return state
    }
    
    /**
     Since the path may have gaps in it caused by starting and stopping, the activity's path is 
     represented as an array of GMSMutablePath objects. This method returns the GMSMutablePath
     object that is actively being updated.
     */
    func getSegment() -> GMSMutablePath {
        return segment
    }
    
    /**
     Returns true if this activity recorder is currently recording. The recorder is considered to be
     recording if it is in the 'Started' or 'Resumed' states.
     */
    func isRecording() -> Bool {
        return state == .Started || state == .Resumed
    }
    
    /**
     Updates the recording with a new GPS location. The location is used to update the
     path, the distance, the duration, and the calories for this recording.
     */
    func update(newLocation: CLLocation, duration: NSTimeInterval) throws {
        if !isRecording() {
            throw RecorderError.IncorrectState
        }
        segment.addCoordinate(newLocation.coordinate)
        lastLocation = currLocation
        currLocation = newLocation
        
        // update the aggregate distance and duration and calories
        let tempDistance = lastLocation != nil ? Converter.metersToFeet(currLocation!.distanceFromLocation(lastLocation!)) : 0
        distance += tempDistance / 5280
        self.duration = duration
        calories =  (BMR / 24) * exerciseType.MET * (duration / 3600)
    }
    
    func getDistance() -> CLLocationDistance {
        return distance
    }
    
    func getCalories() -> Double {
        return calories
    }
    
    func getSpeed() -> Double {
        return currLocation != nil && currLocation!.speed >= 0 ? currLocation!.speed : 0
    }
    
    func start() throws {
        if state != .Created {
            throw RecorderError.IncorrectTransition
        }
        segment = GMSMutablePath()
        state = .Started
    }
    
    func pause() throws {
        if !isRecording() {
            throw RecorderError.IncorrectTransition
        }
        path.append(segment)
        state = .Paused
    }
    
    func resume() throws {
        if state != .Paused {
            throw RecorderError.IncorrectTransition
        }
        segment = GMSMutablePath()
        lastLocation = nil
        currLocation = nil
        state = .Resumed
    }
    
    func stop() throws {
        if state == .Created {
            throw RecorderError.IncorrectTransition
        }
        if isRecording() {
            path.append(segment)
        }
        state = .Stopped
    }
    
    /**
     Custom errors for the recording.
     */
    enum RecorderError: ErrorType {
        case IncorrectState
        case IncorrectTransition
    }
}
