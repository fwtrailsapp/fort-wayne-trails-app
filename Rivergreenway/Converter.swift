//
//  Converter.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 1/23/16.
//  Copyright © 2016 City of Fort Wayne Greenways and Trails Department. All rights reserved.
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
