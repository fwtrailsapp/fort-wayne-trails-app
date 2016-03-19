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
    
    class func feetToMeters(feet: Double) -> Double {
        return feet * 0.3048
    }
    
    class func metersToFeet(meters: Double) -> Double {
        return meters * 3.28084
    }
    
    class func getDurationAsString(duration: NSTimeInterval) -> String {
        let ti = Int(duration)
        let sec = ti % 60
        let min = (ti / 60) % 60
        let hour = ti / 3600
        return String(format: "%0.2d:%0.2d:%0.2d",hour,min,sec)
    }
}