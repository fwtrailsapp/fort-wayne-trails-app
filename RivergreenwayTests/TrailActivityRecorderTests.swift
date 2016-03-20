//
//  TrailActivityRecorderTests.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 1/29/16.
//  Copyright © 2016 City of Fort Wayne Rivergreenways. All rights reserved.
//

import XCTest
@testable import Rivergreenway

class TrailActivityRecorderTests: XCTestCase {
    
    var recorder: TrailActivityRecorder?
    
    override func setUp() {
        super.setUp()
        
        recorder = TrailActivityRecorder(startTime: NSDate(), exerciseType: ExerciseType.Bike)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testConstructor() {
        let recorderNil = TrailActivityRecorder(startTime: NSDate(), exerciseType: ExerciseType.Bike)
        assert(recorderNil.getState() == .Created)
        assert(recorderNil.getCalories() == 0)
        assert(recorderNil.getSpeed() == 0)
        assert(recorderNil.getDistance() == 0)
        assert(recorderNil.getDuration() == 0)
    }
    
    func testStart() {
        do {
            try recorder!.start()
        } catch {
            assert(false)
        }
        assert(recorder!.getState() == .Started)
    }
    
    func testPause() {
        do {
            try recorder!.pause()
            assert(false)
        } catch {
            assert(true)
        }
        
        do {
            try recorder!.start()
        } catch {
            assert(false)
        }
        
        do {
            try recorder!.pause()
        } catch {
            assert(false)
        }
        assert(recorder!.getState() == .Paused)
    }
    
    func testResume() {
        do {
            try recorder!.resume()
            assert(false)
        } catch {
            assert(true)
        }
        
        do {
            try recorder!.start()
        } catch {
            assert(false)
        }
        
        do {
            try recorder!.resume()
            assert(false)
        } catch {
            assert(true)
        }
        
        do {
            try recorder!.pause()
        } catch {
            assert(false)
        }
        
        do {
            try recorder!.resume()
        } catch {
            assert(false)
        }
        assert(recorder!.getState() == .Resumed)
    }
    
    func testStop() {
        do {
            try recorder!.stop()
            assert(false)
        } catch {
            assert(true)
        }
        
        do {
            try recorder!.start()
        } catch {
            assert(false)
        }
        
        do {
            try recorder!.stop()
        } catch {
            assert(false)
        }
        assert(recorder!.getState() == .Stopped)
    }

    func testGetSpeed() {
        do {
            try recorder!.start()
        } catch {
            assert(false)
        }
        
        let locs = initializeLocations()
        
        for loc in locs {
            do {
                try recorder!.update(loc)
                assert(recorder!.getSpeed() == 5)
            } catch {
                assert(false)
            }
        }
    }
    
    func testGetDistance() {
        do {
            try recorder!.start()
        } catch {
            assert(false)
        }
        
        let locs = initializeLocations()
        for loc in locs {
            do {
                try recorder!.update(loc)
            } catch {
                assert(false)
            }
        }
        XCTAssertEqualWithAccuracy(recorder!.getDistance(), 1264 / 5280, accuracy: 0.05)
    }
    
    func testGetDuration() {
        do {
            try recorder!.start()
        } catch {
            assert(false)
        }
        
        let locs = initializeLocations()
        for loc in locs {
            do {
                try recorder!.update(loc)
            } catch {
                assert(false)
            }
        }
        assert(recorder!.getDuration() == 600)
    }
    
    /*
        -85.189383,40.9806756,0.0 -85.1909924,40.9795255,0.0 -85.1926017,40.9782133,0.0
    */
    func initializeLocations() -> [CLLocation] {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        let date1 = dateFormatter.dateFromString("10:30")
        let date2 = dateFormatter.dateFromString("10:35")
        let date3 = dateFormatter.dateFromString("10:40")
        
        var locs = [CLLocation]()
        let coord1 = CLLocationCoordinate2D(latitude: -85.189383,longitude: 40.9806756)
        let coord2 = CLLocationCoordinate2D(latitude: -85.1909924,longitude: 40.9795255)
        let coord3 = CLLocationCoordinate2D(latitude: -85.1926017,longitude: 40.9782133)
        let loc1 = CLLocation(coordinate: coord1, altitude: 0, horizontalAccuracy: 0.5, verticalAccuracy: 0.5, course: 0, speed: 5, timestamp: date1!)
        let loc2 = CLLocation(coordinate: coord2, altitude: 0, horizontalAccuracy: 0.5, verticalAccuracy: 0.5, course: 0, speed: 5, timestamp: date2!)
        let loc3 = CLLocation(coordinate: coord3, altitude: 0, horizontalAccuracy: 0.5, verticalAccuracy: 0.5, course: 0, speed: 5, timestamp: date3!)
        
        locs.append(loc1)
        locs.append(loc2)
        locs.append(loc3)
        
        return locs
    }
}