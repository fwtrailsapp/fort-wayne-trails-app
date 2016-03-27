//
//  RecordActivityStatUnit.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 2/26/16.
//  Copyright © 2016 City of Fort Wayne Greenways and Trails Department. All rights reserved.
//

import Foundation

class UnitLabel: UILabel {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        font = font.fontWithSize(12)
    }
}
