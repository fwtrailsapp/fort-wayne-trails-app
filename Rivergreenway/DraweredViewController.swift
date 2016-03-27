//
//  NavigableViewController.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 2/9/16.
//  Copyright © 2016 City of Fort Wayne Rivergreenways and Trails Department. All rights reserved.
//

import UIKit

class DraweredViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let menuButton = UIBarButtonItem(image: UIImage(named: "Menu"), style: UIBarButtonItemStyle.Plain, target: self, action: "drawerBarButtonPressed")
        navigationItem.leftBarButtonItem = menuButton
    }
    
    func drawerBarButtonPressed() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.drawerController!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }
}
