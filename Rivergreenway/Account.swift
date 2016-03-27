//
//  Account.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 1/21/16.
//  Copyright © 2016 City of Fort Wayne Greenways and Trails Department. All rights reserved.
//

import Foundation

class Account {
    
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
            var c1: Double
            var c2: Double
            var c3: Double
            var c4: Double
            
            switch sex! {
            case Sex.MALE:
                c1 = 88.362
                c2 = 13.397
                c3 = 4.799
                c4 = 5.677
            case Sex.FEMALE:
                c1 = 447.593
                c2 = 9.247
                c3 = 3.098
                c4 = 4.330
            }
            
            let weightKg:Double = Converter.poundsToKilograms(self.weight!)
            let heightCm:Double = Converter.inchesToCentimeters(self.height!)
            let ageYears = getAge()!
            let BMR:Double = c1 + (c2 * weightKg) + (c3 * heightCm) - (c4 * Double(ageYears))
            
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
}
