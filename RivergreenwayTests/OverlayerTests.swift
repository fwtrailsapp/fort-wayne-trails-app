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
