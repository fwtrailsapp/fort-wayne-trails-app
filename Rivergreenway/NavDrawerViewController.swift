//
//  NavDrawerViewController.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 2/9/16.
//  Copyright © 2016 City of Fort Wayne Greenways and Trails Department. All rights reserved.
//

import UIKit

class NavDrawerViewController: UIViewController, UIGestureRecognizerDelegate, NavTableDelegate {
    
    private var selectedCell: CellIdentifier = CellIdentifier.RECORD_ACTIVITY_CELL
    
    @IBOutlet weak var reportProblemLabel: UILabel!
    @IBOutlet weak var reportProblemImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addProblemReportingGestureRecognizers()
    }
    
    func addProblemReportingGestureRecognizers() {
        let labelTap = UITapGestureRecognizer(target: self, action: Selector("openDialer"))
        let imageTap = UITapGestureRecognizer(target: self, action: Selector("openDialer"))
        labelTap.delegate = self
        reportProblemImage.userInteractionEnabled = true
        reportProblemLabel.userInteractionEnabled = true
        
        reportProblemImage.addGestureRecognizer(imageTap)
        reportProblemLabel.addGestureRecognizer(labelTap)
    }
    
    func openDialer() {
        if let url = NSURL(string: "tel://311") {
            UIApplication.sharedApplication().openURL(url)
        }
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
        exit(0)
    }
}
