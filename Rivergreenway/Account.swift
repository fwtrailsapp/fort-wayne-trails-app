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
    
    init(_ decoder: JSONDecoder) throws {
        let uUsername: String = "FIXME!" //try decoder["username"].getString()
        let uBirthYear: Int = try decoder["birthyear"].getInt()
        let uHeight: Double = try decoder["height"].getDouble()
        let uWeight: Double = try decoder["weight"].getDouble()
        let uSex: String = try decoder["sex"].getString()
        
        let oUsername: String? = uUsername
        let oBirthYear: Int? = uBirthYear
        let oHeight: Double? = uHeight
        let oWeight: Double? = uWeight
        let oSex: Sex? = Sex.fromStringIgnoreCase(uSex)
        
        if oUsername == nil || oBirthYear == nil || oHeight == nil || oWeight == nil || oSex == nil {
            throw JSONError.WrongType
        }
        
        self.username = oUsername!
        self.birthYear = oBirthYear!
        self.height = oHeight!
        self.weight = oWeight!
        self.sex = oSex!
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
