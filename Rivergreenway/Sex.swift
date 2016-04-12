//
//  Sex.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 1/22/16.
//  Copyright © 2016 City of Fort Wayne Greenways and Trails Department. All rights reserved.
//

import Foundation

enum Sex: String{
    case Male = "male"
    case Female = "female"
    
    static let all = [Male, Female]
    
    static func fromStringIgnoreCase(string: String) -> Sex? {
        for type in all {
            if string.caseInsensitiveCompare(type.rawValue) == .OrderedSame {
                return type
            }
        }
        return nil
    }
}
