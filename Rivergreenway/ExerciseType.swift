//
//  ExerciseType.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 1/20/16.
//  Copyright © 2016 City of Fort Wayne Rivergreenways. All rights reserved.
//

import Foundation

enum ExerciseType: Double {
    case BIKING = 8.00
    case WALKING = 3.80
    case RUNNING = 7.50
    
    static let all = [BIKING, WALKING, RUNNING]
    
    var imageName: String {
        switch self {
        case BIKING:
            return "Bike"
        case WALKING:
            return "Walk"
        case RUNNING:
            return "Run"
        }
    }
    
    
}