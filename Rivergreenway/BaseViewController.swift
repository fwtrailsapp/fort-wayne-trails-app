//
//  BaseViewController.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 2/9/16.
//  Copyright © 2016 City of Fort Wayne Greenways and Trails Department. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Looks for single or multiple taps.
        // This causes keyboards to be dismissed when a user taps on the screen outside of the
        // keyboard. One would think that would be default behavior; we had to do
        // that manually.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}
