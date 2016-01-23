//
//  Account.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 1/21/16.
//  Copyright © 2016 City of Fort Wayne Rivergreenways. All rights reserved.
//

import Foundation

class Account {
    
    let email: String
    let firstName: String?
    let lastName: String?
    let dob: NSDate?
    let height: Double?
    let weight: Double?
    let sex: Sex?
    
    init(email: String, firstName: String? = nil, lastName: String? = nil, dob: NSDate? = nil, height: Double? = nil, weight: Double? = nil, sex:Sex? = nil) {
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.dob = dob
        self.height = height
        self.weight = weight
        self.sex = sex
    }
    
    func BMR() -> Double? {
        if dob == nil || height == nil || weight == nil || sex == nil {
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
            
            let weight:Double = Converter.poundsToKilograms(self.weight!)
            let height:Double = Converter.inchesToCentimeters(self.height!)
            let age:Int = Int(NSDate().timeIntervalSinceDate(self.dob!))
            
            let BMR:Double = c1 + (c2 * weight) + (c3 * height) - (c4 * Double(age))
            return BMR
        }
    }
    
}