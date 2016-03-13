//
//  ExerciseTypeView.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 3/13/16.
//  Copyright © 2016 City of Fort Wayne Rivergreenways. All rights reserved.
//

import UIKit

class ExerciseTypeView: UIView {

    class func instanceFromNib() -> UIView {
        return UINib(nibName: "ExerciseTypeView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }

}
