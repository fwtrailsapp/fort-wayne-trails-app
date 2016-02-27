//
//  RecordActivityStatUnit.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 2/26/16.
//  Copyright © 2016 City of Fort Wayne Rivergreenways. All rights reserved.
//

import Foundation

class RecordActivityStatUnit: UILabel {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        font = font.fontWithSize(12)
    }
}