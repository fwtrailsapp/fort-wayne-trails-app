//
//  BaseTableViewController.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 2/9/16.
//  Copyright © 2016 City of Fort Wayne Rivergreenways. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {

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
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func transition(destination: UIViewController) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let drawerController = appDelegate.drawerController!
        drawerController.centerViewController = destination
        
        presentViewController(drawerController, animated: true, completion: nil)
    }
}
