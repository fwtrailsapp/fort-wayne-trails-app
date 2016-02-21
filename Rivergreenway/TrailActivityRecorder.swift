//
//  TrailActivityRecorder.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 1/29/16.
//  Copyright © 2016 City of Fort Wayne Rivergreenways. All rights reserved.
//

import Foundation

class TrailActivityRecorder {
    
    private let AVERAGE_BMR: Double = 0;
    
    private var state: TrailActivityState = .CREATED
    private var BMR: Double
    
    private var startTime: NSDate?
    private var endTime: NSDate?
    private var path: [GMSMutablePath]
    private var segment: GMSMutablePath?
    
    private var lastTime: NSDate?
    private var lastLocation: CLLocation?
    private var speed: Double?
    private var lastDistance: Double?
    
    init(BMR: Double?) {
        path = [GMSMutablePath]()
        if BMR == nil {
            self.BMR = AVERAGE_BMR
        } else {
            self.BMR = BMR!
        }
    }
    
    func getState() -> TrailActivityState {
        return state
    }
    
    func setState(newState: TrailActivityState) {
        state = newState
    }
    
    func isRecording() -> Bool {
        return state == .STARTED || state == .RESUMED
    }
    
    func update(newLocation: CLLocation) {
        if segment != nil {
            segment!.addCoordinate(newLocation.coordinate)
        }
    }
    
    func getDistance() -> CLLocationDistance {
        if segment != nil {
            return segment!.lengthOfKind(kGMSLengthGeodesic)
        }
        return 0
    }
    
    func getDuration() -> NSTimeInterval {
        let currTime = NSDate()
        if startTime != nil {
            return Converter.millisecondsToHours(currTime.timeIntervalSinceDate(startTime!) * 1000)
        }
        return 0
    }
    
    func getCalories(MET: Double) -> Double {
        return (BMR / 24) * MET * (getDuration() / 60)
    }
    
    func getSpeed() -> Double {
        return 0
    }
    
    func start() {
        startTime = NSDate()
        segment = GMSMutablePath()
        state = .STARTED
    }
    
    func pause() {
        path.append(segment!)
        segment = nil
        state = .PAUSED
    }
    
    func resume() {
        segment = GMSMutablePath()
        state = .RESUMED
    }
    
    func stop() {
        endTime = NSDate()
        state = .STOPPED
    }
}