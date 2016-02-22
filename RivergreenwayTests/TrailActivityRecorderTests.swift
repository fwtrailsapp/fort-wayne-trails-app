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
        
        recorder = TrailActivityRecorder()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testConstructor() {
        let recorderNil = TrailActivityRecorder()
        assert(recorderNil.getState() == .CREATED)
        assert(recorderNil.getCalories() == 0)
        assert(recorderNil.getSpeed() == 0)
        assert(recorderNil.getDistance() == 0)
        assert(recorderNil.getDuration() == 0)
    }
    
    func testStart() {
        do {
            try recorder!.start(exerciseType: .RUNNING)
        } catch {
            assert(false)
        }
        assert(recorder!.getState() == .STARTED)
    }
    
    func testPause() {
        do {
            try recorder!.pause()
            assert(false)
        } catch {
            assert(true)
        }
        
        do {
            try recorder!.start(exerciseType: .RUNNING)
        } catch {
            assert(false)
        }
        
        do {
            try recorder!.pause()
        } catch {
            assert(false)
        }
        assert(recorder!.getState() == .PAUSED)
    }
    
    func testResume() {
        do {
            try recorder!.resume()
            assert(false)
        } catch {
            assert(true)
        }
        
        do {
            try recorder!.start(exerciseType: .RUNNING)
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
        assert(recorder!.getState() == .RESUMED)
    }
    
    func testStop() {
        do {
            try recorder!.stop()
            assert(false)
        } catch {
            assert(true)
        }
        
        do {
            try recorder!.start(exerciseType: .RUNNING)
        } catch {
            assert(false)
        }
        
        do {
            try recorder!.stop()
        } catch {
            assert(false)
        }
        assert(recorder!.getState() == .STOPPED)
    }
}