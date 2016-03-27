//
//  UserStatisticsResponse.swift
//  Rivergreenway
//
//  Created by Jared P on 3/24/16.
//  Copyright © 2016 City of Fort Wayne Rivergreenways and Trails Department. All rights reserved.
//

import Foundation
import JSONJoy

struct UserStatisticsResponse : JSONJoy {
    let stats: [SingleStatistic]
    
    init(_ decoder: JSONDecoder) throws {
        guard let ra = decoder["GetTotalStatsForUserResult"].array else {
            throw JSONError.WrongType
        }
        
        var statsArray = [SingleStatistic]()
        for item in ra {
            guard let thisStatistic = try? SingleStatistic(item) else {
                throw JSONError.WrongType
            }
            statsArray.append(thisStatistic)
        }
        self.stats = statsArray
    }
}

struct SingleStatistic : JSONJoy {
    let calories: Int
    let distance: Double
    let duration: NSTimeInterval
    let type: String
    
    init(_ decoder: JSONDecoder) throws {
        let uCalories = try decoder["total_calories"].getInt()
        let uDistance = try decoder["total_distance"].getDouble()
        let uDuration = try decoder["total_duration"].getString()
        let uType = try decoder["type"].getString()
        
        let oCalories: Int? = uCalories
        let oDistance: Double? = uDistance
        let oDuration: NSTimeInterval? = Converter.stringToTimeInterval(uDuration)
        let oType: String? = uType
        
        if oCalories == nil || oDistance == nil || oDuration == nil || oType == nil {
            throw JSONError.WrongType
        }
        
        self.calories = oCalories!
        self.distance = oDistance!
        self.duration = oDuration!
        self.type = oType!
    }
}
