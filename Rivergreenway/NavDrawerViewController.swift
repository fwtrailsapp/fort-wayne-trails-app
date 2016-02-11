//
//  NavDrawerViewController.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 2/9/16.
//  Copyright © 2016 City of Fort Wayne Rivergreenways. All rights reserved.
//

import UIKit

class NavDrawerViewController: UIViewController {
    
    private var navTable: NavDrawerTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let embeddedController = segue.destinationViewController as? NavDrawerTableViewController where segue.identifier == "NavDrawerTableSegue" {
            
            self.navTable = embeddedController
        }
    }
}