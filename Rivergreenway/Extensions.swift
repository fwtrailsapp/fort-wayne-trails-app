//
//  Extensions.swift
//  Rivergreenway
//
//  Created by Jared P on 4/15/16.
//  Copyright © 2016 City of Fort Wayne Greenways and Trails Department. All rights reserved.
//

import Foundation
import JSONJoy

extension JSONDecoder {
    public func getStringOptional() throws -> String? {
        if isNull() {return nil}
        guard let str = string else {throw JSONError.WrongType}
        return str
    }
    
    public func getIntOptional() throws -> Int? {
        if isNull() {return nil}
        guard let i = integer else {throw JSONError.WrongType}
        return i
    }
    
    public func getFloatOptional() throws -> Float? {
        if isNull() {return nil}
        guard let i = float else {throw JSONError.WrongType}
        return i
    }
    
    public func getDoubleOptional() throws -> Double? {
        if isNull() {return nil}
        guard let i = double else {throw JSONError.WrongType}
        return i
    }
    
    public func isNull() -> Bool {
        if let raw = rawValue {
            if let rawNS = raw as? NSObject {
                if rawNS == NSNull() {
                    return true
                }
            }
        }
        return false
    }
}