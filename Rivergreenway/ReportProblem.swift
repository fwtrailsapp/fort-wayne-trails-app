//
//  ReportProblem.swift
//  Rivergreenway
//
//  Created by Neil Rawlins on 2/7/17.
//  Copyright © 2017 City of Fort Wayne Greenways and Trails Department. All rights reserved.
//

import Foundation
import JSONJoy

class ReportProblem : DictionarySerializable {

    var type: String
    var description: String?
    var active: Int
    var imgLink: String?
    var latitude: Double?
    var longitude: Double?
    var title: String
    var date: String?
    var username: String
    var notes: String?
    var dateClosed: String?
    
    init(type: String, description: String? = nil, active: Int, imgLink: String? = nil, latitude: Double? = nil, longitude: Double? = nil, title: String, date: String? = nil, username: String, notes: String? = nil, dateClosed: String? = nil) {
        self.type = type
        self.description = description
        self.active = active
        self.imgLink = imgLink
        self.latitude = latitude
        self.longitude = longitude
        self.title = title
        self.date = date
        self.username = username
        self.notes = notes
        self.dateClosed = dateClosed
    }
    
    init(_ decoder: JSONDecoder) throws {
        self.type = try decoder["type"].getString()
        self.description = try decoder["description"].getStringOptional()
        self.active = try decoder["active"].getInt()
        self.imgLink = try decoder["imgLink"].getStringOptional()
        self.latitude = try decoder["latitude"].getDoubleOptional()
        self.longitude = try decoder["longitude"].getDoubleOptional()
        self.title = try decoder["title"].getString()
        self.date = try decoder["date"].getStringOptional()
        self.username = try decoder["username"].getString()
        self.notes = try decoder["notes"].getStringOptional()
        self.dateClosed = try decoder["dateClosed"].getStringOptional()
    }

    func toDictionary() -> [String: NSObject] {
        return [
            "type" : self.type,
            "description" : self.description ?? NSNull(),
            "active" : self.active,
            "imgLink" : self.imgLink ?? NSNull(),
            "latitude" : self.latitude ?? NSNull(),
            "longitude" : self.longitude ?? NSNull(),
            "title" : self.title,
            "date" : self.date ?? NSNull(),
            "username" : self.username,
            "notes" : self.notes ?? NSNull(),
            "dateClosed": self.dateClosed ?? NSNull()
               ]
    }
}
