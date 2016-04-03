//
//  TrailMapViewController.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 2/13/16.
//  Copyright © 2016 City of Fort Wayne Greenways and Trails Department. All rights reserved.
//

import UIKit

/**
 Displays a static version of the trail map (as opposed to a dynamically generated
 GMSMapView). This is useful for the users to be able to view a map of the trails without needing
 much mobile data.
 */
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
