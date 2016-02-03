//
//  OverlayerTests.swift
//  Rivergreenway
//
//  Created by Jared P on 1/24/16.
//  Copyright © 2016 City of Fort Wayne Rivergreenways. All rights reserved.
//

import XCTest
@testable import Rivergreenway

class OverlayerTests: XCTestCase {
    var ov: Overlayer?
    let kmlUrl = "https://gist.githubusercontent.com/libjared/4b703481eccad557807c/raw/78ebe13d134c8fdb4c14c62c37cad5b2a02af133/dude.kml"

    override func setUp() {
        super.setUp()
        ov = Overlayer()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func canLoadKML() {
        ov!.loadKMLFromURL(kmlUrl)
    }
    
    func failDude() {
        XCTFail("Are you paying attention?")
    }
}
