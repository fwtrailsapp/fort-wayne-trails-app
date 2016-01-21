//
//  TestTrailActivity.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 1/16/16.
//  Copyright © 2016 City of Fort Wayne Rivergreenways. All rights reserved.
//

import Foundation

class TrailActivity {
    
    var timeStamp: NSTimeInterval
    var state: TrailActivityState
    
    init(timeStamp: NSTimeInterval) {
        self.timeStamp = timeStamp
        state = TrailActivityState.CREATED
    }
    
    func transitionState(newState: TrailActivityState) {
        state = newState
    }
}

