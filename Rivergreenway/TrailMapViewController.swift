//
//  TrailMapViewController.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 2/13/16.
//  Copyright © 2016 City of Fort Wayne Greenways and Trails Department. All rights reserved.
//

import UIKit

class TrailMapViewController: DraweredViewController {
    
    @IBOutlet weak var mapImageView: UIImageView!
    @IBAction func mapSectionSegmentedControlPressed(sender: UISegmentedControl) {
        mapImageView.image = UIImage(named: "\(sender.titleForSegmentAtIndex(sender.selectedSegmentIndex)!)Map")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
