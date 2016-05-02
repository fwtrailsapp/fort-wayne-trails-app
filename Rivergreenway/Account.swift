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
//  Account.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 1/21/16.
//  Copyright © 2016 City of Fort Wayne Greenways and Trails Department. All rights reserved.
//

import Foundation
import JSONJoy

/**
 Represents an account - password is not stored here for security reasons.
 */
class Account : DictionarySerializable {
    
    var username: String
    var birthYear: Int?
    var height: Double?
    var weight: Double?
    var sex: Sex?
    
    init(username: String, birthYear: Int? = nil, height: Double? = nil, weight: Double? = nil, sex:Sex? = nil) {
        self.username = username
        self.birthYear = birthYear
        self.height = height
        self.weight = weight
        self.sex = sex
    }
    
    //make an account from JSON. this needs username because for some reason the server's response doesn't provide it
    init(_ decoder: JSONDecoder, username: String) throws {
        self.username = username
        self.birthYear = try decoder["birthyear"].getIntOptional()
        self.height = try decoder["height"].getDoubleOptional()
        self.weight = try decoder["weight"].getDoubleOptional()
        
        //sex is transmitted as string, we need to convert to the Sex type
        let optStrSex: String? = try decoder["sex"].getStringOptional()
        if let strSex = optStrSex {
            self.sex = Sex.fromStringIgnoreCase(strSex)
        } else {
            self.sex = nil
        }
    }
    
    func BMR() -> Double? {
        if birthYear == nil || height == nil || weight == nil || sex == nil {
            return nil
        } else {
            var sexConstant = 0
            
            switch sex! {
            case Sex.Male:
                sexConstant = 5
                break
            case Sex.Female:
                sexConstant = -161
                break
            }
            
            let weightKg:Double = Converter.poundsToKilograms(self.weight!)
            let heightCm:Double = Converter.inchesToCentimeters(self.height!)
            let ageYears = getAge()!
            
            let adjustedWeight = 10 * weightKg
            let adjustedHeight = 6.25 * heightCm
            let adjustedAge = 5.0 * Double(ageYears)
            
            let BMR:Double = adjustedWeight + adjustedHeight - adjustedAge + Double(sexConstant)
            return BMR
        }
    }
    
    func getAge() -> Int? {
        if birthYear == nil {
            return nil
        }
        let currDate = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Year], fromDate: currDate)
        
        return components.year - birthYear!
    }
    
    /**
     Implements DictionarySerializable protocol's toDictionary function. This returns
     this Account object as a dictionary.  
     */
    func toDictionary() -> [String: NSObject] {
        return ["username": username,
                "birthyear": birthYear ?? NSNull(),
                "height": height ?? NSNull(),
                "weight": weight ?? NSNull(),
                "sex": sex?.rawValue ?? NSNull()]
    }
}
