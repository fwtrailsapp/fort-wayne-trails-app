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
//  AccountStatisticsViewController.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 2/13/16.
//  Copyright © 2016 City of Fort Wayne Greenways and Trails Department. All rights reserved.
//

import UIKit

/**
 Displays the account statistics for the user. The statistics are displayed in
 two categories: overall statistics and per-exercise-type statistics. Each category
 has its own section in a static table view controller (see the main storyboard for the
 exact look). 
 
 The per-exercise-type section has a segmented control for selecting an exercise type;
 once selected, the per-exercise-type section is populated with the data for that
 exercise type.
 */
class AccountStatisticsViewController: DraweredTableViewController {

    
    @IBOutlet weak var overallDurationLabel: UILabel!
    @IBOutlet weak var overallDistanceLabel: UILabel!
    @IBOutlet weak var overallCaloriesLabel: UILabel!
    
    @IBOutlet weak var typeDurationLabel: UILabel!
    @IBOutlet weak var typeDistanceLabel: UILabel!
    @IBOutlet weak var typeCaloriesLabel: UILabel!
    
    @IBOutlet weak var exerciseTypeControl: UISegmentedControl!
    
    var userStatisticsResponse: UserStatisticsResponse?

    @IBAction func exerciseTypeControlChanged(sender: UISegmentedControl) {
        populateFieldsFromExerciseTypeControl()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewControllerUtilities.populateExerciseTypeSegmentedControl(exerciseTypeControl)
        
        SVProgressHUD.show()
        
        WebStore.getUserStatistics(
            errorCallback: {error in
                dispatch_async(dispatch_get_main_queue(),{
                    ViewControllerUtilities.genericErrorHandler(self, error: error)
                })
            },
            successCallback: {response in
                dispatch_async(dispatch_get_main_queue(),{
                    self.onGetUserStatisticsSuccess(response)
                })
            }
        )
    }
    
    func onGetUserStatisticsSuccess(response: UserStatisticsResponse) {
        self.userStatisticsResponse = response
        
        // populates the 'Overall' stats section
        if let overallIndex = userStatisticsResponse!.stats.indexOf({$0.type == "Overall"}) {
            populateFieldsForSingleStatistic(userStatisticsResponse!.stats[overallIndex])
        }
        
        // populates the per-exercise-type section
        populateFieldsFromExerciseTypeControl()
        
        SVProgressHUD.dismiss()
    }
    
    /**
     Gets the selected value from the segmented control for the exercise type
     and populates the per-exercise-section with the statistics for that
     exercise type.
     */
    func populateFieldsFromExerciseTypeControl() {
        let exerciseType = ExerciseType.all[exerciseTypeControl.selectedSegmentIndex]
        if userStatisticsResponse != nil {
            if let statIndex = userStatisticsResponse!.stats.indexOf({$0.type == exerciseType.rawValue}) {
                populateFieldsForSingleStatistic(userStatisticsResponse!.stats[statIndex])
            }
        }
    }
    
    func populateFieldsForSingleStatistic(statistic: SingleStatistic) {
        if statistic.type == "Overall" {
            overallDurationLabel.text = Converter.timeIntervalToString(statistic.duration)
            overallDistanceLabel.text = Converter.doubleToString(statistic.distance)
            overallCaloriesLabel.text = "\(statistic.calories)"
        } else {
            typeDurationLabel.text = Converter.timeIntervalToString(statistic.duration)
            typeDistanceLabel.text = Converter.doubleToString(statistic.distance)
            typeCaloriesLabel.text = "\(statistic.calories)"
        }
    }

}
