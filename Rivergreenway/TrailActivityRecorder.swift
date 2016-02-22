//
//  TrailActivityRecorder.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 1/29/16.
//  Copyright © 2016 City of Fort Wayne Rivergreenways. All rights reserved.
//

import Foundation

class TrailActivityRecorder {
    
    private let AVERAGE_BMR: Double = 1577.5
    
    private var state: TrailActivityState = .CREATED
    private var exerciseType: ExerciseType?
    private var BMR: Double
    
    private var startTime: NSDate?
    private var path: [GMSMutablePath]
    private var segment: GMSMutablePath
    
    private var lastTime: NSDate?
    private var lastLocation: CLLocation?
    private var lastDistance: CLLocationDistance = 0
    private var lastDuration: NSTimeInterval = 0
    private var speed: Double = 0
    private var distance: CLLocationDistance = 0
    private var duration: NSTimeInterval = 0
    private var calories: Double = 0
    
    init(BMR: Double? = nil) {
        path = [GMSMutablePath]()
        segment = GMSMutablePath()
        if BMR == nil {
            self.BMR = AVERAGE_BMR
        } else {
            self.BMR = BMR!
        }
    }
    
    func getState() -> TrailActivityState {
        return state
    }
    
    func isRecording() -> Bool {
        return state == .STARTED || state == .RESUMED
    }
    
    func update(newLocation: CLLocation, newTime: NSDate) throws {
        if state != .STARTED || state != .RESUMED {
            throw RecorderError.INCORRECT_STATE
        }
        segment.addCoordinate(newLocation.coordinate)

        // update the change in distance and change in location
        // since the last update
        updateLastDistance(newLocation)
        updateLastDuration(newTime)
        
        // update the aggregate distance and duration and calories
        distance += lastDistance
        duration += lastDuration
        updateCalories()
        
        lastTime = newTime
        lastLocation = newLocation
    }
    
    func getDistance() -> CLLocationDistance {
        return distance
    }
    
    func getDuration() -> NSTimeInterval {
        return duration
    }
    
    func getCalories() -> Double {
        return calories
    }
    
    func getSpeed() -> Double {
        if lastDistance == 0 || lastDuration == 0 {
            return 0
        }
        return lastDistance / lastDuration
    }
    
    private func updateCalories() {
        if exerciseType != nil {
            calories +=  (BMR / 24) * exerciseType!.rawValue * (lastDuration / 60)
        }
    }
    
    private func updateLastDistance(newLocation: CLLocation) {
        if lastLocation != nil {
            lastDistance = lastLocation!.distanceFromLocation(newLocation)
        }
    }
    
    private func updateLastDuration(newTime: NSDate) {
        if lastTime != nil {
            lastDuration = lastTime!.timeIntervalSinceDate(newTime)
        } else {
            lastDuration = startTime!.timeIntervalSinceDate(newTime)
        }
    }
    
    func start(startTime: NSDate = NSDate(), exerciseType: ExerciseType) throws {
        if state != .CREATED {
            throw RecorderError.INCORRECT_TRANSITION
        }
        self.startTime = startTime
        segment = GMSMutablePath()
        state = .STARTED
    }
    
    func pause() throws {
        if state != .STARTED && state != .RESUMED {
            throw RecorderError.INCORRECT_TRANSITION
        }
        path.append(segment)
        segment.removeAllCoordinates()
        state = .PAUSED
    }
    
    func resume() throws {
        if state != .PAUSED {
            throw RecorderError.INCORRECT_TRANSITION
        }
        segment = GMSMutablePath()
        state = .RESUMED
    }
    
    func stop() throws {
        if state == .CREATED {
            throw RecorderError.INCORRECT_TRANSITION
        }
        if state == .RESUMED || state == .STARTED {
            path.append(segment)
        }
        state = .STOPPED
    }
    
    enum RecorderError: ErrorType {
        case INCORRECT_STATE
        case INCORRECT_TRANSITION
    }
}