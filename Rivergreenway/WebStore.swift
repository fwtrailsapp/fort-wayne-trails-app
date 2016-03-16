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
            if let err = response.error {
                let errSentToCallback = self.getErrorFromRequest(err)
                errorCallback(error: errSentToCallback)
            } else {
                //response is ok
                successCallback(response)
            }
        }
    }
    
    private func getErrorFromRequest(err: NSError) -> WebStoreError {
        if err.domain == "HTTP" {
            switch (err.code) {
            case 400:
                return WebStoreError.InvalidCommunication
            case 401:
                return WebStoreError.BadCredentials
            case 404:
                return WebStoreError.InvalidCommunication
            default: break
            }
        }
        //domain is not http or the http response code isn't listed
        return WebStoreError.Unknown(msg: "Unknown error in WebStore: \(err.localizedDescription)")
    }
}
