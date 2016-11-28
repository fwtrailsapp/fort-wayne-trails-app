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
//  TestUtils.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 4/13/16.
//  Copyright © 2016 City of Fort Wayne Greenways and Trails Department. All rights reserved.
//

import Foundation
@testable import Rivergreenway

class TestUtils {
    
    class func createTrailActivity() -> TrailActivity {
        let startTime = Date()
        let duration = 20.0
        let distance = 1337.0
        let path = createMutablePaths()
        let exerciseType = ExerciseType.Bike
        let caloriesBurned = 10.0
        return TrailActivity(startTime: startTime, duration: duration, distance: distance, path: path, exerciseType: exerciseType, caloriesBurned: caloriesBurned)
    }
    
    class func createMutablePaths() -> [GMSMutablePath] {
        let firstPath = GMSMutablePath()
        firstPath.add(CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0))
        firstPath.add(CLLocationCoordinate2D(latitude: 0.1, longitude: 0.1))
        
        let secondPath = GMSMutablePath()
        secondPath.add(CLLocationCoordinate2D(latitude: 0.2, longitude: 0.2))
        secondPath.add(CLLocationCoordinate2D(latitude: 0.3, longitude: 0.3))
        
        var manyPaths = [GMSMutablePath]()
        manyPaths.append(firstPath)
        manyPaths.append(secondPath)
        
        return manyPaths
    }
}
