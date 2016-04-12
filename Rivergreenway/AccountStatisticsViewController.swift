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
                    self.onGetUserStatisticsError()
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
    
    func onGetUserStatisticsError() {
        ViewControllerUtilities.displayServerConnectionErrorAlert(self, message: WebStoreError.InvalidCommunication.description)
        SVProgressHUD.dismiss()
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
