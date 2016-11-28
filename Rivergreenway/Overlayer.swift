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
//  KMLManager.swift
//  Rivergreenway
//
//  Created by Jared P on 1/24/16.
//  Copyright © 2016 City of Fort Wayne Greenways and Trails Department. All rights reserved.
//

import Foundation

class Overlayer {
    let mapView : GMSMapView
    var addedPaths : [GMSPolyline]
    
    init(mapView : GMSMapView) {
        self.mapView = mapView
        self.addedPaths = [GMSPolyline]()
    }
    
    func loadKMLFromURL(url : String) throws {
        let root = KMLParser.parseKMLAtURL(NSURL(string: url))
        if root == nil {
            throw OverlayerError.CannotLoadURL //KML root is nil, possibly a network error
        }
        
        guard let placemarks = root.placemarks() as? [KMLPlacemark] where placemarks.count > 0 else {
            throw OverlayerError.CannotLoadURL //KML has no placemarks
        }
        
        for mark in placemarks {
            switch (mark.geometry)
            {
            case let linestr as KMLLineString:
                try addLineString(linestr)
                break
            default:
                //ignore point, linearring, polygon, multigeometry,
                //model, gx:track, and gx:multitrack
                break
            }
        }
    }
    
    func addLineString(linestr: KMLLineString) throws {
        let path = GMSMutablePath()
        
        guard let coords = linestr.coordinates as? [KMLCoordinate] else {
            throw OverlayerError.BadCoords
        }
        
        for coord in coords {
            let lat = Float(coord.latitude)
            let long = Float(coord.longitude)
            path.addLatitude(CLLocationDegrees(lat), longitude: CLLocationDegrees(long))
        }
        let poly = GMSPolyline(path: path)
        poly.strokeWidth = 6
        poly.strokeColor = UIColor.blackColor()
        addedPaths.append(poly)
        poly.map = mapView
    }
    
    internal var geometryCount : Int {
        return addedPaths.count;
    }
}

enum OverlayerError: ErrorType {
    case CannotLoadURL
    case BadCoords
}