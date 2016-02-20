//
//  TrailActivityRecorder.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 1/29/16.
//  Copyright © 2016 City of Fort Wayne Rivergreenways. All rights reserved.
//

import Foundation

class TrailActivityRecorder {
    
    private var state: TrailActivityState = .CREATED
    
    func getState() -> TrailActivityState {
        return state
    }
    
    func setState(newState: TrailActivityState) {
        state = newState
    }
}