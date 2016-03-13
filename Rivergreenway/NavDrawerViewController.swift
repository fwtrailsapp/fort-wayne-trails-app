//
//  NavDrawerViewController.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 2/9/16.
//  Copyright © 2016 City of Fort Wayne Rivergreenways. All rights reserved.
//

import UIKit

class NavDrawerViewController: UIViewController, NavTableDelegate {
    
    private var selectedCell: CellIdentifier = CellIdentifier.RECORD_ACTIVITY_CELL
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let embeddedController = segue.destinationViewController as? NavDrawerTableViewController where segue.identifier == "NavDrawerTableSegue" {
            embeddedController.setDelegate(self)
        }
    }
    
    func cellPressed(cellID: CellIdentifier) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if cellID == selectedCell {
            appDelegate.drawerController!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
            return
        }
        
        var newViewController: UIViewController?
        let mainStoryboard: UIStoryboard = UIStoryboard(name: ViewIdentifier.MAIN_STORYBOARD.rawValue, bundle: nil)
        
        
        switch(cellID) {
        case .RECORD_ACTIVITY_CELL:
            newViewController = mainStoryboard.instantiateViewControllerWithIdentifier(ViewIdentifier.RECORD_ACTIVITY_NAV_CONTROLLER.rawValue)
            break
        case .ACTIVITY_HISTORY_CELL:
            newViewController = mainStoryboard.instantiateViewControllerWithIdentifier(ViewIdentifier.ACTIVITY_HISTORY_NAV_CONTROLLER.rawValue)
            break
        case .ACHIEVEMENTS_CELL:
            newViewController = mainStoryboard.instantiateViewControllerWithIdentifier(ViewIdentifier.ACHIEVEMENT_NAV_CONTROLLER.rawValue)
            break
        case .TRAIL_MAP_CELL:
            newViewController = mainStoryboard.instantiateViewControllerWithIdentifier(ViewIdentifier.TRAIL_MAP_NAV_CONTROLLER.rawValue)
            break
        case .ACCOUNT_STATISTICS_CELL:
            newViewController = mainStoryboard.instantiateViewControllerWithIdentifier(ViewIdentifier.ACCOUNT_STATISTICS_NAV_CONTROLLER.rawValue)
            break
        case .ACCOUNT_DETAILS_CELL:
            newViewController = mainStoryboard.instantiateViewControllerWithIdentifier(ViewIdentifier.ACCOUNT_DETAILS_NAV_CONTROLLER.rawValue)
            break
        case .ABOUT_CELL:
            newViewController = mainStoryboard.instantiateViewControllerWithIdentifier(ViewIdentifier.ABOUT_NAV_CONTROLLER.rawValue)
            break
        case .EXIT_CELL:
            confirmLogOut()
            break
        }
        if newViewController != nil {
            appDelegate.drawerController!.centerViewController = newViewController!
            selectedCell = cellID
        }
        appDelegate.drawerController!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }
    
    func confirmLogOut() {
        let alert = UIAlertController(title: "Log Out", message: "Are you sure you wish to log out?", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: logOutHandler))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(alert, animated: false, completion: nil)
    }
    
    func logOutHandler(action: UIAlertAction) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.logout()
    }
}