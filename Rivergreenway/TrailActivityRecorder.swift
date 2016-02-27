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
    
    private var path: [GMSMutablePath]
    private var segment: GMSMutablePath
    
    private var currLocation: CLLocation?
    private var lastLocation: CLLocation?
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
    
    func getSegment() -> GMSMutablePath {
        return segment
    }
    
    func isRecording() -> Bool {
        return state == .STARTED || state == .RESUMED
    }
    
    func update(newLocation: CLLocation) throws {
        if (state != .STARTED && state != .RESUMED) || exerciseType == nil {
            throw RecorderError.INCORRECT_STATE
        }
        segment.addCoordinate(newLocation.coordinate)
        lastLocation = currLocation
        currLocation = newLocation
        
        // update the aggregate distance and duration and calories
        let tempDistance = lastLocation != nil ? Converter.metersToFeet(currLocation!.distanceFromLocation(lastLocation!)) : 0
        distance += tempDistance / 5280
        duration += lastLocation != nil ? currLocation!.timestamp.timeIntervalSinceDate(lastLocation!.timestamp) : 0
        calories =  (BMR / 24) * exerciseType!.rawValue * (duration / 3600)
    }
    
    func getDistance() -> CLLocationDistance {
        return distance
    }
    
    func getDuration() -> NSTimeInterval {
        return duration
    }
    
    func getDurationAsString() -> String {
        let ti = Int(duration)
        let sec = ti % 60
        let min = (ti / 60) % 60
        let hour = ti / 3600
        return String(format: "%0.2d:%0.2d:%0.2d",hour,min,sec)
    }
    
    func getCalories() -> Double {
        return calories
    }
    
    func getSpeed() -> Double {
        return currLocation != nil ? currLocation!.speed : 0
    }
    
    func start(exerciseType: ExerciseType) throws {
        if state != .CREATED {
            throw RecorderError.INCORRECT_TRANSITION
        }
        self.exerciseType = exerciseType
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
        lastLocation = nil
        currLocation = nil
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