//
//  WebStoreError.swift
//  Rivergreenway
//
//  Created by Jared P on 3/16/16.
//  Copyright © 2016 City of Fort Wayne Rivergreenways. All rights reserved.
//

import Foundation

enum WebStoreError: CustomStringConvertible {
    case BadCredentials
    case InvalidCommunication
    case Unknown(msg: String)
    
    var description: String {
        switch (self) {
        case .BadCredentials:
            return "Cannot login with that username or password."
        case .InvalidCommunication:
            return "Either the server did not understand us, or we did not understand the server."
        case let .Unknown(msg):
            return msg
        }
    }
}