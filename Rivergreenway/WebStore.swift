//
//  WebStore.swift
//  Rivergreenway
//
//  Created by Jared P on 2/20/16.
//  Copyright © 2016 City of Fort Wayne Greenways and Trails Department. All rights reserved.
//

import Foundation
import SwiftHTTP
import JSONJoy

class WebStore {
    private static let baseUrl = "http://68.39.46.187:50000/GreenwayCap/DataRelay.svc/trails/api/1/"
    private static var authToken : String? = nil
    static var lastUsername : String? = nil
    static var lastPassword : String? = nil

    class func login(username: String, password: String,
                     errorCallback: (error: WebStoreError) -> Void,
                     successCallback: () -> Void)
    {
        lastUsername = username
        lastPassword = password
        
        let url = baseUrl + "login"
        
        let params = ["username": username, "password": password]
        
        genericRequest(HTTPVerb.POST, url: url, params: params, tryAutoLogin: false,
            errorCallback: errorCallback,
            successCallback: { response in
                let json = JSONDecoder(response.data)
                let token = try? json["token"].getString()
                guard let realToken = token else {
                    errorCallback(error: WebStoreError.InvalidCommunication)
                    return
                }
                authToken = realToken
                successCallback()
            }
        )
    }
    
    class var hasAuthToken: Bool { get { return authToken != nil } }
    
    class func createAccount(acct: Account, password: String,
        errorCallback: (error: WebStoreError) -> Void,
        successCallback: () -> Void)
    {
        let url = baseUrl + "account/create"
        
        var params = acct.toDictionary()
        params["password"] = password
        
        genericRequest(HTTPVerb.POST, url: url, params: params, tryAutoLogin: true,
            errorCallback: errorCallback,
            successCallback: { response in
                successCallback()
            }
        )
    }
    
    class func getAccount(errorCallback
        errorCallback: (error: WebStoreError) -> Void,
        successCallback: (Account) -> Void)
    {
        let url = baseUrl + "account"
        
        genericRequest(HTTPVerb.GET, url: url, params: nil, tryAutoLogin: true,
            errorCallback: errorCallback,
            successCallback: { response in
                let oAcct = try? Account(JSONDecoder(response.data))
                guard let acct = oAcct else {
                    errorCallback(error: WebStoreError.InvalidCommunication)
                    return
                }
                successCallback(acct)
            }
        )
    }
    
    class func editAccount(account: Account, password: String? = nil,
                           errorCallback: (error: WebStoreError) -> Void,
                           successCallback: () -> Void)
    {
        let url = baseUrl + "account/edit"
        var params = account.toDictionary()
        if password == nil {
            params["password"] = lastPassword
        } else {
            params["password"] = password
        }
        
        genericRequest(HTTPVerb.POST, url: url, params: params, tryAutoLogin: true, errorCallback: errorCallback,
                       successCallback: { response in
                        successCallback()
            }
        )
    }
    
    class func createNewActivity(act: TrailActivity,
        errorCallback: (error: WebStoreError) -> Void,
        successCallback: () -> Void)
    {
        guard act.getPath() != nil else {
            errorCallback(error: WebStoreError.Unknown(msg: "This activity has no path associated with it."))
            return
        }
        
        let url = baseUrl + "activity"
        let params = act.toDictionary()
        genericRequest(HTTPVerb.POST, url: url, params: params, tryAutoLogin: true, errorCallback: errorCallback, successCallback: { response in
            successCallback()
        })
    }
    
    class func getActivityHistory(errorCallback
        errorCallback: (error: WebStoreError) -> Void,
        successCallback: (TrailActivityHistoryResponse) -> Void)
    {
        let url = baseUrl + "activity"
        
        genericRequest(HTTPVerb.GET, url: url, params: nil, tryAutoLogin: true,
            errorCallback: errorCallback, successCallback: { response in
                let oActHist = try? TrailActivityHistoryResponse(JSONDecoder(response.data))
                guard let actHist = oActHist else {
                    errorCallback(error: WebStoreError.InvalidCommunication)
                    return
                }
                successCallback(actHist)
            }
        )
    }
    
    class func getUserStatistics(errorCallback
        errorCallback: (error: WebStoreError) -> Void,
        successCallback: (UserStatisticsResponse) -> Void)
    {
        let url = baseUrl + "statistics"
        
        genericRequest(HTTPVerb.GET, url: url, params: nil, tryAutoLogin: true,
            errorCallback: errorCallback, successCallback: { response in
                let oUserStats = try? UserStatisticsResponse(JSONDecoder(response.data))
                guard let userStats = oUserStats else {
                    errorCallback(error: WebStoreError.InvalidCommunication)
                    return
                }
                successCallback(userStats)
            }
        )
    }
    
    class func clearState() {
        //mainly for testing. remove auth token and credentials if any
        authToken = nil
        lastUsername = nil
        lastPassword = nil
    }
    
    class private func genericRequest(verb: HTTPVerb, url: String, params: [String: NSObject]?,
                                      tryAutoLogin: Bool,
                                      errorCallback: (error: WebStoreError) -> Void,
                                      successCallback: (Response) -> Void)
    {
        genericRequestInternal(verb, url: url, params: params,
            errorCallback:
            { error in
                if (isBadCredentials(error) && tryAutoLogin && lastUsername != nil && lastPassword != nil) {
                    login(lastUsername!, password: lastPassword!,
                        errorCallback:
                        { errorLogin in
                            errorCallback(error: WebStoreError.BadCredentials)
                        }, successCallback:
                        { response in
                            genericRequest(verb, url: url, params: params, tryAutoLogin: false,
                                errorCallback: errorCallback,
                                successCallback: successCallback)
                        }
                    )
                } else {
                    errorCallback(error: error)
                }
            }, successCallback:
            { response in
                successCallback(response)
            }
        )
    }
    
    class private func isBadCredentials(error: WebStoreError) -> Bool {
        switch error {
        case .BadCredentials:
            return true
        default:
            return false
        }
    }
    
    class private func genericRequestInternal(verb: HTTPVerb, url: String, params: [String: NSObject]?,
        errorCallback: (error: WebStoreError) -> Void,
        successCallback: (Response) -> Void)
    {
        let serializer = JSONParameterSerializer()
        let opt: HTTP
        
        var headers = [String: String]()
        if let realAuthToken = authToken {
            headers["Trails-Api-Key"] = realAuthToken
        }
        
        do {
            opt = try HTTP.New(url, method: verb, requestSerializer: serializer,
                parameters: params, headers: headers)
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
    
    private class func getErrorFromRequest(err: NSError) -> WebStoreError {
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
        return WebStoreError.Unknown(msg: "Unknown error in WebStore: \(err.localizedDescription) (code: \(err.code))")
    }
}
