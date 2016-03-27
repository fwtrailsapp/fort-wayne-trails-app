//
//  OverlayerTests.swift
//  Rivergreenway
//
//  Created by Jared P on 1/24/16.
//  Copyright © 2016 City of Fort Wayne Greenways and Trails Department. All rights reserved.
//

import XCTest
@testable import Rivergreenway

class OverlayerTests: XCTestCase {
    var ov: Overlayer?
    let kmlUrl = "https://gist.githubusercontent.com/libjared/4b703481eccad557807c/raw/78ebe13d134c8fdb4c14c62c37cad5b2a02af133/dude.kml"

    override func setUp() {
        super.setUp()
        GMSServices.provideAPIKey("AIzaSyAd2mmJznzk-8mPpVzlGgxD06Yh6yo18Pg")
        let mapView = GMSMapView()
        ov = Overlayer(mapView: mapView)
    }
    
    func loadGoodUrl() {
        try! ov!.loadKMLFromURL(kmlUrl)
    }
    
    func testCanLoadKML() {
        loadGoodUrl()
    }
    
    func testPathsLoaded() {
        measureBlock() {
            self.loadGoodUrl()
        }
        assert(ov!.geometryCount >= 1)
    }
    
    func testBadUrl() {
        do {
            try ov!.loadKMLFromURL("https://www.google.com")
        } catch (OverlayerError.CannotLoadURL) {
            return
        } catch {
            XCTFail("Should have gotten a CannotLoadURL error first")
        }
        XCTFail("Should have gotten a CannotLoadURL error")
    }
    
    override func tearDown() {
        super.tearDown()
    }
}
