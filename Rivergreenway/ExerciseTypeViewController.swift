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
            var exerciseType: ExerciseType?
            switch(exerciseTypeControl.selectedSegmentIndex) {
            case 0:
                exerciseType = .Walk
                break
            case 1:
                exerciseType = .Run
                break
            case 2:
                exerciseType = .Bike
                break
            default:
                exerciseType = .Walk
                break
            }
            delegate!.start(exerciseType!)
        }
    }
    
    @IBOutlet weak var exerciseTypeControl: UISegmentedControl!
    private var delegate: ExerciseTypeViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setDelegate(delegate: ExerciseTypeViewControllerDelegate) {
        self.delegate = delegate
    }
}

protocol ExerciseTypeViewControllerDelegate {
    func start(exerciseType: ExerciseType)
}