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
//  SingleButtonViewController.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 2/17/16.
//  Copyright © 2016 City of Fort Wayne Greenways and Trails Department. All rights reserved.
//

import UIKit

class StartPauseViewController: BaseViewController, UIPopoverPresentationControllerDelegate, ExerciseTypeViewControllerDelegate {

    // MARK : - Properties
    
    private var delegate: StartPauseDelegate?
    private let exerciseTypeSegueID = "PromptExerciseType"
    
    @IBOutlet weak var startPauseButton: UIButton!
    
    // MARK : - Actions
    
    @IBAction func startButtonPressed(sender: UIButton) {
        if let title = startPauseButton.titleLabel!.text {
            if title == "Start" {
                self.performSegueWithIdentifier(exerciseTypeSegueID, sender: self)
            }
            else {
                delegate!.pause()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == exerciseTypeSegueID {
            let exerciseTypeViewController = segue.destinationViewController as! ExerciseTypeViewController
            let popoverController = exerciseTypeViewController.popoverPresentationController
            exerciseTypeViewController.preferredContentSize = CGSize(width: 200, height: 150)
            if popoverController != nil {
                popoverController!.sourceRect = startPauseButton.bounds
                exerciseTypeViewController.setDelegate(self)
                popoverController!.delegate = self
            }
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        // Return no adaptive presentation style, use default presentation behaviour
        return .None
    }
    
    func start(exerciseType: ExerciseType) {
        if delegate != nil {
            // manually dismiss the popover view
            self.presentedViewController!.dismissViewControllerAnimated(true, completion: nil)
            startPauseButton.setTitle("Pause", forState: .Normal)
            delegate!.start(exerciseType)
        }
    }
    
    func setDelegate(delegate: StartPauseDelegate) {
        self.delegate = delegate
    }
    
    func resetView() {
        startPauseButton.setTitle("Start", forState: .Normal)
    }
}

protocol StartPauseDelegate {
    func start(exerciseType: ExerciseType)
    func pause()
}
