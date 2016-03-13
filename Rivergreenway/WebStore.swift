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
        successCallback: () -> Void)
    {
        let url = baseUrl + "login"
        let params = ["username": username, "password": password]
        
        genericPOST(url, params: params,
            errorCallback: errorCallback,
            successCallback: { response in
                let resp = JSONDecoder(response.data)
                self.authToken = resp["authtoken"].string
                successCallback()
            }
        )
    }

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
        
        genericPOST(url, params: params,
            errorCallback: errorCallback,
            successCallback: { response in
                successCallback()
            }
        )
    }
    
    func getAccount(
        errorCallback: (error: WebStoreError) -> Void,
        successCallback: (AccountDetailsResponse) -> Void)
    {
        let url = baseUrl + "account"
        
        genericGET(url,
            errorCallback: errorCallback,
            successCallback: { response in
                let acctDeets = AccountDetailsResponse(JSONDecoder(response.data))
                
                if !acctDeets.isValid() {
                    errorCallback(error: WebStoreError.InvalidResponse)
                    return
                }
                
                successCallback(acctDeets)
            }
        )
    }
    
    struct AccountDetailsResponse: JSONJoy {
        let dob: Int?
        var weight: Float?
        let sex: Sex?
        let height: Float?
        
        init(_ decoder: JSONDecoder) {
            dob = decoder["dob"].integer
            weight = decoder["weight"].float
            if let theSex = decoder["sex"].string {
                self.sex = Sex(rawValue: theSex)
            } else {
                self.sex = nil
            }
            height = decoder["height"].float
        }
        
        func isValid() -> Bool {
            return
                dob != nil &&
                weight != nil &&
                sex != nil &&
                height != nil
        }
    }
    
    func genericGET(url: String,
        errorCallback: (error: WebStoreError) -> Void,
        successCallback: (Response) -> Void)
    {
        let serializer = JSONParameterSerializer()
        let headers = ["Content-Type": "application/json"]
        let opt: HTTP
        
        do {
            opt = try HTTP.GET(url, parameters: nil, headers: headers, requestSerializer: serializer)
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
    
    func genericPOST(url: String, params: [String: NSObject],
        errorCallback: (error: WebStoreError) -> Void,
        successCallback: (Response) -> Void)
    {
        let serializer = JSONParameterSerializer()
        let headers = ["Content-Type": "application/json"]
        let opt: HTTP
        
        do {
            opt = try HTTP.POST(url, requestSerializer: serializer,
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
    case InvalidResponse
    case Unknown(msg: String)
    
    var description: String {
        switch (self) {
        case .BadCredentials:
            return "Cannot login with that username or password."
        case .InvalidResponse:
            return "Server returned less data than expected."
        case let .Unknown(msg):
            return msg
        }
    }
}