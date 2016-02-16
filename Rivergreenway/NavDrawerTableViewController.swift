//
//  NavDrawerTableViewController.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 2/10/16.
//  Copyright © 2016 City of Fort Wayne Rivergreenways. All rights reserved.
//

import UIKit

class NavDrawerTableViewController: UITableViewController {
    
    private var selectedCell: CellIdentifier = CellIdentifier.RECORD_ACTIVITY_CELL
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let identifier = (tableView.cellForRowAtIndexPath(indexPath)?.reuseIdentifier)!
        let cellID = CellIdentifier(rawValue: identifier)!
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
            break
        case .ACCOUNT_DETAILS_CELL:
            break
        case .ABOUT_CELL:
            break
        case .EXIT_CELL:
            break
        }
        
        appDelegate.drawerController!.centerViewController = newViewController!
        appDelegate.drawerController!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
        selectedCell = cellID
    }
}

enum CellIdentifier: String {
    case RECORD_ACTIVITY_CELL = "RecordActivityCell"
    case ACTIVITY_HISTORY_CELL = "ActivityHistoryCell"
    case ACHIEVEMENTS_CELL = "AchievementsCell"
    case TRAIL_MAP_CELL = "TrailMapCell"
    case ACCOUNT_STATISTICS_CELL = "AccountStatisticsCell"
    case ACCOUNT_DETAILS_CELL = "AccountDetailsCell"
    case ABOUT_CELL = "AboutCell"
    case EXIT_CELL = "ExitCell"
}