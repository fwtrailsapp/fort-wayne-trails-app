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
//  ViewUtilities.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 4/2/16.
//  Copyright © 2016 City of Fort Wayne Greenways and Trails Department. All rights reserved.
//

import Foundation

class ViewControllerUtilities {
    
    class func populateExerciseTypeSegmentedControl(exerciseTypeControl: UISegmentedControl) {
        for index in 0...ExerciseType.all.count - 1 {
            if index >= exerciseTypeControl.numberOfSegments {
                exerciseTypeControl.insertSegmentWithImage(UIImage(named: ExerciseType.all[index].rawValue), atIndex: index, animated: false)
            } else {
                exerciseTypeControl.setImage(UIImage(named:  ExerciseType.all[index].rawValue), forSegmentAtIndex: index)
            }
        }
    }
    
    class func transition(controller: UIViewController, destination: ViewIdentifier) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: ViewIdentifier.MAIN_STORYBOARD.rawValue, bundle: nil)
        let viewController = mainStoryboard.instantiateViewControllerWithIdentifier(destination.rawValue)
        controller.presentViewController(viewController, animated: true, completion: nil)
    }
    
    class func transitionDrawered(controller: UIViewController, destination: ViewIdentifier) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: ViewIdentifier.MAIN_STORYBOARD.rawValue, bundle: nil)
        let viewController = mainStoryboard.instantiateViewControllerWithIdentifier(destination.rawValue)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let drawerController = appDelegate.drawerController!
        drawerController.centerViewController = viewController
        
        controller.presentViewController(drawerController, animated: true, completion: nil)
    }
    
    class func displayServerConnectionErrorAlert(controller: UIViewController, message: String) {
        let alert = UIAlertController(title: "Connection Error", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        controller.presentViewController(alert, animated: false, completion: nil)
    }
    
    class func genericErrorHandler(viewController: UIViewController, error: WebStoreError) {
        SVProgressHUD.dismiss()
        ViewControllerUtilities.displayServerConnectionErrorAlert(viewController, message: error.description)
    }
    
    class func getAccount() -> Account? {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return appDelegate.account
    }
    
}