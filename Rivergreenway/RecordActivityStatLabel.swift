//
//  RecordActivityStatLabel.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 2/18/16.
//  Copyright © 2016 City of Fort Wayne Greenways and Trails Department. All rights reserved.
//

import UIKit

class RecordActivityStatLabel: UILabel {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        font = font.fontWithSize(32)
    }

}
