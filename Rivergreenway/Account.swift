//
//  Account.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 1/21/16.
//  Copyright © 2016 City of Fort Wayne Greenways and Trails Department. All rights reserved.
//

import Foundation

/**
 Represents an account - password is not stored here for security reasons.
 */
class Account : DictionarySerializable {
    
    let username: String
    let birthYear: Int?
    let height: Double?
    let weight: Double?
    let sex: Sex?
    
    init(username: String, birthYear: Int? = nil, height: Double? = nil, weight: Double? = nil, sex:Sex? = nil) {
        self.username = username
        self.birthYear = birthYear
        self.height = height
        self.weight = weight
        self.sex = sex
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
                "birthYear": birthYear ?? NSNull(),
                "height": height ?? NSNull(),
                "weight": weight ?? NSNull(),
                "sex": sex?.rawValue ?? NSNull()]
    }
}
