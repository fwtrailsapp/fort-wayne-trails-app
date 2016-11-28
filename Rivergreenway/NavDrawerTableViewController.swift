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
