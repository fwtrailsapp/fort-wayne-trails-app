//
//  NavDrawerTableViewController.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 2/10/16.
//  Copyright © 2016 City of Fort Wayne Rivergreenways. All rights reserved.
//

import UIKit

class NavDrawerTableViewController: UITableViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("table view loaded")
        // Do any additional setup after loading the view.
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("button clicked")
        
        let identifier = (tableView.cellForRowAtIndexPath(indexPath)?.reuseIdentifier)!
        
        switch(CellIdentifier(rawValue: identifier)) {
        case .RECORD_ACTIVITY_CELL?:
            print("record activity clicked")
            break
        case .ACTIVITY_HISTORY_CELL?:
            print("activity history clicked")
            break
        case .ACHIEVEMENTS_CELL?:
            break
        case .TRAIL_MAP_CELL?:
            break
        case .ACCOUNT_STATISTICS_CELL?:
            break
        case .ACCOUNT_DETAILS_CELL?:
            break
        case .ABOUT_CELL?:
            break
        case .EXIT_CELL?:
            break
        default:
            print("default option")
            break
        }
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