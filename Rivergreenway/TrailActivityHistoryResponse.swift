//
//  TrailActivityHistoryResponse.swift
//  Rivergreenway
//
//  Created by Jared P on 3/20/16.
//  Copyright © 2016 City of Fort Wayne Rivergreenways and Trails Department. All rights reserved.
//

import Foundation
import JSONJoy

struct TrailActivityHistoryResponse : JSONJoy {
    let activities: [TrailActivity]
    
    init(_ decoder: JSONDecoder) throws {
        guard let ra = decoder["GetActivitiesForUserResult"].array else {
            throw JSONError.WrongType
        }
        
        var acts = [TrailActivity]()
        for item in ra {
            guard let thisActivity = try? TrailActivity(item) else {
                throw JSONError.WrongType
            }
            acts.append(thisActivity)
        }
        
        self.activities = acts
    }
}
