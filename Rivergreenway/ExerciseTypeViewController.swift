//
//  ExerciseTypeViewController.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 3/19/16.
//  Copyright © 2016 City of Fort Wayne Rivergreenways. All rights reserved.
//

import UIKit

class ExerciseTypeViewController: UIViewController {

    @IBAction func startButtonPressed(sender: UIButton) {
        if delegate != nil {
            delegate!.start(ExerciseType.all[exerciseTypeControl.selectedSegmentIndex])
        }
    }
    
    @IBOutlet weak var exerciseTypeControl: UISegmentedControl!
    private var delegate: ExerciseTypeViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for index in 0...ExerciseType.all.count - 1 {
            exerciseTypeControl.setImage(UIImage(named:  ExerciseType.all[index].rawValue), forSegmentAtIndex: index)
        }
    }
    
    func setDelegate(delegate: ExerciseTypeViewControllerDelegate) {
        self.delegate = delegate
    }
}

protocol ExerciseTypeViewControllerDelegate {
    func start(exerciseType: ExerciseType)
}