//
//  ViewUtilities.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 4/2/16.
//  Copyright © 2016 City of Fort Wayne Greenways and Trails Department. All rights reserved.
//

import Foundation

class ViewControllerUtilities {
 
    class func getAccount() -> Account {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return appDelegate.getAccount()!
    }
    
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
    
}