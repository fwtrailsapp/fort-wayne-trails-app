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
    private let baseUrl = "http://68.39.46.187:50000/GreenwayCap/DataRelay.svc/"

    func createAccount(acct: Account, password: String,
        errorCallback: (error: WebStoreError) -> Void,
        successCallback: () -> Void)
    {
        let url = baseUrl + "account/create"
        
        var params = [String: NSObject]()
        
        params["username"] = acct.username
        params["password"] = password
        params["dob"] = acct.birthYear ?? NSNull()
        
        if let uHeight = acct.height {
            params["height"] = Int(uHeight)
        } else {
            params["height"] = NSNull()
        }
        
        if let uWeight = acct.weight {
            params["weight"] = Int(uWeight)
        } else {
            params["weight"] = NSNull()
        }
        
        if let uSex = acct.sex {
            params["sex"] = uSex.rawValue
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
    
    func createNewActivity(username: String, act: TrailActivity,
        errorCallback: (error: WebStoreError) -> Void,
        successCallback: () -> Void)
    {
        guard let realPath = act.getPath() else {
            errorCallback(error: WebStoreError.Unknown(msg: "This activity has no path associated with it."))
            return
        }
        
        let uUsername: String = username
        let uTimeStarted: String = nsDateToString(act.getStartTime(), format: "yyyy-MM-dd'T'HH:mm:ss")
        let uDuration: String = Converter.getDurationAsString(act.getDuration())
        let uMileage: Double = act.getDistance()
        let uCaloriesBurned: Int = Int(act.getCaloriesBurned())
        let uExerciseType: String = act.getExerciseType().rawValue
        let uPath: String = pathsToString(realPath)
        
        /*
        int CreateNewActivity(string username, string time_started, string duration, float mileage, int calories_burned, string exercise_type, string path)
        */
        
        let url = baseUrl + "activity"
        var params = [String: NSObject]()
        params["username"] = uUsername
        params["time_started"] = uTimeStarted
        params["duration"] = uDuration
        params["mileage"] = uMileage
        params["calories_burned"] = uCaloriesBurned
        params["exercise_type"] = uExerciseType
        params["path"] = uPath
        
        genericRequest(HTTPVerb.POST, url: url, params: params, errorCallback: errorCallback, successCallback: { response in
            successCallback()
        })
    }
    
    private func pathsToString(paths: [GMSMutablePath]) -> String {
        //send all of the paths hooked together... god help us
        var coords = [String]()
        
        for path in paths {
            for index in 0...path.count() {
                let thisCoord = path.coordinateAtIndex(index)
                let lat = thisCoord.latitude
                let long = thisCoord.longitude
                coords.append("\(lat) \(long)")
            }
        }
        
        let joined = coords.joinWithSeparator(",")
        
        return joined
    }
    
    private func nsDateToString(date: NSDate, format: String) -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = format
        return formatter.stringFromDate(date)
    }
    
    private func genericRequest(verb: HTTPVerb, url: String, params: [String: NSObject]?,
        errorCallback: (error: WebStoreError) -> Void,
        successCallback: (Response) -> Void)
    {
        let serializer = JSONParameterSerializer()
        let opt: HTTP
        
        do {
            opt = try HTTP.New(url, method: verb, requestSerializer: serializer,
                parameters: params)
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
        return WebStoreError.Unknown(msg: "Unknown error in WebStore: \(err.localizedDescription) (code: \(err.code))")
    }
}
