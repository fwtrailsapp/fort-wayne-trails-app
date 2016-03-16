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
    let baseUrl = "http://68.39.46.187:50000/GreenwayCap/DataRelay.svc/"

    func accountCreate(acct: Account, password: String,
        errorCallback: (error: WebStoreError) -> Void,
        successCallback: () -> Void)
    {
        let url = baseUrl + "account/create"
        
        var params = [String: NSObject]()
        
        params["username"] = acct.username
        params["password"] = password
        params["dob"] = acct.birthYear ?? NSNull()
        params["height"] = acct.height ?? NSNull()
        params["weight"] = acct.weight ?? NSNull()
        
        if let sex = acct.sex {
            params["sex"] = sex.rawValue
        } else {
            params["sex"] = NSNull()
        }
        
        genericRequest(HTTPVerb.POST, url: url, params: params,
            errorCallback: errorCallback,
            successCallback: { response in
                successCallback()
            }
        )
    }
    
    private func genericRequest(verb: HTTPVerb, url: String, params: [String: NSObject],
        errorCallback: (error: WebStoreError) -> Void,
        successCallback: (Response) -> Void)
    {
        let serializer = JSONParameterSerializer()
        let headers = ["Content-Type": "application/json"]
        let opt: HTTP
        
        do {
            opt = try HTTP.New(url, method: verb, requestSerializer: serializer,
                headers: headers, parameters: params)
        } catch let errorEx {
            errorCallback(error: WebStoreError.Unknown(msg: "Exception: \(errorEx)"))
            return
        }
        
        opt.start { response in
            //handle the generic errors
            if let err = response.error {
                var errSentToCallback : WebStoreError
                
                //TODO: add more error codes
                if err.domain == "HTTP" && err.code == 401 {
                    errSentToCallback = WebStoreError.BadCredentials
                } else {
                    print("unknown WebStore error: \(err.localizedDescription)")
                    errSentToCallback = WebStoreError.Unknown(msg: err.localizedDescription)
                }
                errorCallback(error: errSentToCallback)
            } else { //response is ok
                successCallback(response)
            }
        }
    }
}

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