//
//  AccountResponse.swift
//  Rivergreenway
//
//  Created by Jared P on 3/16/16.
//  Copyright © 2016 City of Fort Wayne Greenways and Trails Department. All rights reserved.
//

import Foundation
import JSONJoy

struct AccountResponse : JSONJoy {
    let dob: Int
    let weight: Float
    let height: Float
    let sex: Sex
    
    init(_ decoder: JSONDecoder) throws {
        self.dob = try decoder["dob"].getInt()
        self.weight = try decoder["weight"].getFloat()
        self.height = try decoder["height"].getFloat()
        let sexStr = try decoder["sex"].getString()
        guard let tSex = Sex(rawValue: sexStr) else {
            throw JSONError.WrongType
        }
        self.sex = tSex
    }
}
