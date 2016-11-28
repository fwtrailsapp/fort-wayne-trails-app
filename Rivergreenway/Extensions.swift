//
// Copyright (C) 2016 Jared Perry, Jaron Somers, Warren Barnes, Scott Weidenkopf, and Grant Grimm
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software
// and associated documentation files (the "Software"), to deal in the Software without restriction,
// including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all copies
// or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
// LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
// WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH
// THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
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