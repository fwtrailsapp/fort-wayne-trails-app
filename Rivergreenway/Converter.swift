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
//  Converter.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 1/23/16.
//  Copyright © 2016 City of Fort Wayne Greenways and Trails Department. All rights reserved.
//

import Foundation

/**
 Class for unit conversions ;)
 */
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
    
    class func timeIntervalToString(duration: NSTimeInterval) -> String {
        let ti = Int(duration)
        let sec = ti % 60
        let min = (ti / 60) % 60
        let hour = ti / 3600
        return String(format: "%0.2d:%0.2d:%0.2d",hour,min,sec)
    }
    
    class func stringToDate(dateStr: String) -> NSDate? {
        let format = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return format.dateFromString(dateStr)
    }
    
    class func doubleToString(number: Double) -> String {
        return String(format: "%.2f", number)
    }
    
    /**
     Converts array of GMSMutablePaths to a String
     */
    class func pathsToString(paths: [GMSMutablePath]) -> String {
        //send all of the paths hooked together... god help us
        var coords = [String]()
        
        for path in paths {
            if path.count() > 0 {
                for index in 0..<path.count() {
                    let thisCoord = path.coordinateAtIndex(index)
                    let lat = thisCoord.latitude
                    let long = thisCoord.longitude
                    let format = "%.7f"
                    coords.append("\(String(format: format, lat)) \(String(format: format, long))")
                }
            }
        }
        
        let joined = coords.joinWithSeparator(",")
        return joined
    }
    
    /**
     Converts an NSDate into a string using the provided format.
     */
    class func dateToString(date: NSDate, format: String = "yyyy-MM-dd'T'HH:mm:ss") -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = format
        return formatter.stringFromDate(date)
    }
    
    class func stringToTimeInterval(intervalStr: String) -> NSTimeInterval? {
        //a time interval string can be
        //[d.]hh:mm:ss[.fffffff]
        //where d is days and f are fractional seconds
        
        //we'll parse this by splitting by colon -> [d.hh, mm, ss.fffffff]
        //then splitting by period in the first index of the above -> [d, hh] or maybe [hh]
        
        let split = intervalStr.componentsSeparatedByString(":")
        if split.count != 3 {
            return nil
        }
        
        let dayHour = split[0] //d.hh or hh
        let dayHourArray = dayHour.componentsSeparatedByString(".")
        
        var oDay: Int? = 0
        if dayHourArray.count == 2 { //we have a day
            oDay = Int(dayHourArray.first!)
        }
        
        let oHour: Int? = Int(dayHourArray.last!)
        let oMin = Int(split[1])
        let oSec = Double(split[2])
        
        guard let day = oDay else {
            return nil
        }
        guard let hour = oHour else {
            return nil
        }
        guard let min = oMin else {
            return nil
        }
        guard let sec = oSec else {
            return nil
        }
        
        let finalSec = Double(day*24*60*60) + Double(hour*60*60) + Double(min*60) + sec
        return NSTimeInterval(finalSec)
    }
}