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
