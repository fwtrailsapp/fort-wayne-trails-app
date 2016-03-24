//
//  BaseViewController.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 2/9/16.
//  Copyright © 2016 City of Fort Wayne Rivergreenways. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    func transition(destination: ViewIdentifier) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: ViewIdentifier.MAIN_STORYBOARD.rawValue, bundle: nil)
        let viewController = mainStoryboard.instantiateViewControllerWithIdentifier(destination.rawValue)
        presentViewController(viewController, animated: true, completion: nil)
    }
    
    func transitionDrawered(destination: ViewIdentifier) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: ViewIdentifier.MAIN_STORYBOARD.rawValue, bundle: nil)
        let viewController = mainStoryboard.instantiateViewControllerWithIdentifier(destination.rawValue)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let drawerController = appDelegate.drawerController!
        drawerController.centerViewController = viewController
        
        presentViewController(drawerController, animated: true, completion: nil)
    }
    
    func displayServerConnectionErrorAlert(message: String) {
        let alert = UIAlertController(title: "Connection Error", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(alert, animated: false, completion: nil)
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func getAccount() -> Account {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return appDelegate.getAccount()!
    }
    
    func populateExerciseTypeSegmentedControl(exerciseTypeControl: UISegmentedControl) {
        for index in 0...ExerciseType.all.count - 1 {
            if index >= exerciseTypeControl.numberOfSegments {
                exerciseTypeControl.insertSegmentWithImage(UIImage(named: ExerciseType.all[index].rawValue), atIndex: index, animated: false)
            } else {
                exerciseTypeControl.setImage(UIImage(named:  ExerciseType.all[index].rawValue), forSegmentAtIndex: index)
            }
        }
    }
}
