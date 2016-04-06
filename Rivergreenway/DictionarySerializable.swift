//
//  DictionarySerializable.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 4/3/16.
//  Copyright © 2016 City of Fort Wayne Greenways and Trails Department. All rights reserved.
//

import Foundation

/**
 SwiftHTTP can serialize Swift dictionaries into JSON automatically. Our models
 that implement this protocol thus can be serialized into JSON automatically.
 */
protocol DictionarySerializable {
    func toDictionary() -> [String: NSObject]
}