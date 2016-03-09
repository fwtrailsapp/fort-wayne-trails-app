//
//  SingleButtonViewController.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 2/17/16.
//  Copyright © 2016 City of Fort Wayne Rivergreenways. All rights reserved.
//

import UIKit

class StartPauseViewController: BaseViewController {

    // MARK : - Properties
    
    private var delegate: StartPauseDelegate?
    
    @IBOutlet weak var startPauseButton: UIButton!
    
    // MARK : - Actions
    
    @IBAction func startButtonPressed(sender: UIButton) {
        if let title = startPauseButton.titleLabel!.text {
            if title == "Start" {
                delegate!.start()
                startPauseButton.setTitle("Pause", forState: .Normal)
                
            }
            else {
                delegate!.pause()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setDelegate(delegate: StartPauseDelegate) {
        self.delegate = delegate
    }
    
    func resetView() {
        startPauseButton.setTitle("Start", forState: .Normal)
    }
}

protocol StartPauseDelegate {
    func start()
    func pause()
}