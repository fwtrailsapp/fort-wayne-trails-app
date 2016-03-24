//
//  ExerciseType.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 1/20/16.
//  Copyright © 2016 City of Fort Wayne Rivergreenways. All rights reserved.
//

import Foundation

enum ExerciseType: String {
    case Bike = "Bike"
    case Walk = "Walk"
    case Run = "Run"
    
    static func fromStringIgnoreCase(s: String) -> ExerciseType? {
        for t in all {
            if s.caseInsensitiveCompare(t.rawValue) == .OrderedSame {
                return t
            }
        }
        return nil
    }
    
    static let all = [Walk, Run, Bike]
    
    var MET: Double {
        switch self {
        case Bike:
            return 8.00
        case Walk:
            return 3.80
        case Run:
            return 7.50
        }
    }
}