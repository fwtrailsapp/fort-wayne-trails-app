//
//  SingleButtonViewController.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 2/17/16.
//  Copyright © 2016 City of Fort Wayne Rivergreenways and Trails Department. All rights reserved.
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
