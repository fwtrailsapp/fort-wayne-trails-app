//
//  ExerciseTypeViewController.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 3/19/16.
//  Copyright © 2016 City of Fort Wayne Rivergreenways and Trails Department. All rights reserved.
//

import UIKit

class ExerciseTypeViewController: BaseViewController {

    @IBAction func startButtonPressed(sender: UIButton) {
        if delegate != nil {
            delegate!.start(ExerciseType.all[exerciseTypeControl.selectedSegmentIndex])
        }
    }
    
    @IBOutlet weak var exerciseTypeControl: UISegmentedControl!
    private var delegate: ExerciseTypeViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateExerciseTypeSegmentedControl(exerciseTypeControl)
    }
    
    func setDelegate(delegate: ExerciseTypeViewControllerDelegate) {
        self.delegate = delegate
    }
}

protocol ExerciseTypeViewControllerDelegate {
    func start(exerciseType: ExerciseType)
}
