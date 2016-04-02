//
//  NavDrawerTableViewController.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 2/10/16.
//  Copyright © 2016 City of Fort Wayne Greenways and Trails Department. All rights reserved.
//

import UIKit

/**
 A view controller for the nav drawer table. Each cell in the table links to on of the
 views in this application.
 
 The table is implemented as a separate view controller, rather than being simply a child view
 in the nav drawer view controller, because, as of March 2016, static cells can only be
 implemented in UITableViewController classes. Since the nav drawer table is static in nature,
 meaning that we know exactly what its contents will be prior to runtime, it made more
 sense to make the table static, even if it meant making it its own view controller.
 */
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
