//
//  WebStore.swift
//  Rivergreenway
//
//  Created by Jared P on 2/20/16.
//  Copyright © 2016 City of Fort Wayne Rivergreenways. All rights reserved.
//

import Foundation
import SwiftHTTP
import JSONJoy

class WebStore {
    let baseUrl = "http://localhost:8080/trails/api/1/"
    var authToken : String?
    
    func login(username: String, password: String,
        errorCallback: (error: WebStoreError) -> Void,
        successCallback: () -> Void) {
        let url = baseUrl + "login"
        let serializer = JSONParameterSerializer()
        let headers = ["Content-Type": "application/json"]
        let params = ["username": username, "password": password]
        
        do {
            let opt = try HTTP.POST(url, requestSerializer: serializer,
                headers: headers, parameters: params)
            opt.start { response in
                //handle the generic errors
                if let err = response.error {
                    var errSentToCallback : WebStoreError = WebStoreError.Unknown(msg: err.localizedDescription)
                    if err.domain == "HTTP" && err.code == 401 {
                        errSentToCallback = WebStoreError.BadCredentials
                    } else {
                        print("unknown WebStore error: \(err.localizedDescription)")
                    }
                    errorCallback(error: errSentToCallback)
                } else { //response is ok
                    let resp = JSONDecoder(response.data)
                    self.authToken = resp["authtoken"].string
                    successCallback()
                }
            }
        } catch let errorEx {
            errorCallback(error: WebStoreError.Unknown(msg: "Exception: \(errorEx)"))
        }
    }
}

enum WebStoreError: CustomStringConvertible {
    case BadCredentials
    case Unknown(msg: String)
    
    var description: String {
        switch (self) {
        case .BadCredentials:
            return "Cannot login with that username or password."
        case let .Unknown(msg):
            return msg
        }
    }
}