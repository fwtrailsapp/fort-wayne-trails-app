//
//  NavDrawerTableViewController.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 2/10/16.
//  Copyright © 2016 City of Fort Wayne Rivergreenways. All rights reserved.
//

import UIKit

class NavDrawerTableViewController: UITableViewController {
    
    
    private var delegate: NavTableDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func setDelegate(delegate: NavTableDelegate) {
        self.delegate = delegate
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let identifier = (tableView.cellForRowAtIndexPath(indexPath)?.reuseIdentifier)!
        let cellID = CellIdentifier(rawValue: identifier)!
        
        delegate!.cellPressed(cellID)
    }
}

protocol NavTableDelegate {
    func cellPressed(cellID: CellIdentifier)
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