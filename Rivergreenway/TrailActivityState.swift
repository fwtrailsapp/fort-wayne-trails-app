//
//  TrailActivityState.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 1/16/16.
//  Copyright © 2016 City of Fort Wayne Greenways and Trails Department. All rights reserved.
//

import Foundation

enum TrailActivityState: String {
    case Created = "Created"
    case Started = "Started"
    case Resumed = "Resumed"
    case Paused = "Paused"
    case Stopped = "Stopped"
    case Destroyed = "Destroyed"
}
