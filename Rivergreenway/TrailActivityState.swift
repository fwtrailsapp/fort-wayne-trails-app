//
//  TrailActivityState.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 1/16/16.
//  Copyright © 2016 City of Fort Wayne Rivergreenways. All rights reserved.
//

import Foundation

enum TrailActivityState: String {
    case CREATED = "CREATED"
    case STARTED = "STARTED"
    case RESUMED = "RESUMED"
    case PAUSED = "PAUSED"
    case STOPPED = "STOPPED"
    case DESTROYED = "DESTROYED"
}