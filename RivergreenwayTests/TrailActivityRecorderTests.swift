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
//  TrailActivityRecorderTests.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 1/29/16.
//  Copyright © 2016 City of Fort Wayne Greenways and Trails Department. All rights reserved.
//

import XCTest
@testable import Rivergreenway

class TrailActivityRecorderTests: XCTestCase {
    
    var recorder: TrailActivityRecorder?
    
    override func setUp() {
        super.setUp()
        
        recorder = TrailActivityRecorder(startTime: Date(), exerciseType: ExerciseType.Bike)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testConstructor() {
        let recorderNil = TrailActivityRecorder(startTime: Date(), exerciseType: ExerciseType.Bike)
        assert(recorderNil.getState() == .Created)
        assert(recorderNil.getCalories() == 0)
        assert(recorderNil.getSpeed() == 0)
        assert(recorderNil.getDistance() == 0)
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
    
    /*
        -85.189383,40.9806756,0.0 -85.1909924,40.9795255,0.0 -85.1926017,40.9782133,0.0
    */
    func initializeLocations() -> [CLLocation] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        let date1 = dateFormatter.date(from: "10:30")
        let date2 = dateFormatter.date(from: "10:35")
        let date3 = dateFormatter.date(from: "10:40")
        
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
