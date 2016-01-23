//
//  Converter.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 1/23/16.
//  Copyright © 2016 City of Fort Wayne Rivergreenways. All rights reserved.
//

import Foundation

class Converter {
    
    class func poundsToKilograms(pounds: Double) -> Double {
        return pounds * 0.453592
    }
    
    class func inchesToCentimeters(inches: Double) -> Double {
        return inches * 2.54
    }
    
    class func millisecondsToHours(milliseconds: NSTimeInterval) -> NSTimeInterval{
        return milliseconds * (1 / 3600000)
    }
    
    class func hoursToMilliseconds(hours: NSTimeInterval) -> NSTimeInterval {
        return hours * 3600000
    }
    
    class func feetToMeters(feet: Double) -> Double {
        return feet * 0.3048
    }
    
    class func metersToFeet(meters: Double) -> Double {
        return meters * 3.28084
    }
}