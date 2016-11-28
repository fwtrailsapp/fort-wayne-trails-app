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
//  ActivityHistoryViewController.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 2/10/16.
//  Copyright © 2016 City of Fort Wayne Greenways and Trails Department. All rights reserved.
//

import UIKit

/**
 Tabulates the user's Acitivity History by querying the server. Each activity's exercise type, duration,
 distance, calories, and date are displayed.
 */
class ActivityHistoryViewController: DraweredTableViewController {
    
    private let cellID = "ActivityHistoryCell"
    private var activities: [TrailActivity]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SVProgressHUD.show()
        WebStore.getActivityHistory(
            errorCallback: {error in
                dispatch_async(dispatch_get_main_queue(),{
                    ViewControllerUtilities.genericErrorHandler(self, error: error)
                })
            },
            successCallback: {trails in
                dispatch_async(dispatch_get_main_queue(),{
                    self.onActivityHistoryGetSuccess(trails)
                })
        })
    }
    
    func onActivityHistoryGetSuccess(response: TrailActivityHistoryResponse) {        activities = response.activities
        self.tableView.reloadData()
        SVProgressHUD.dismiss()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // if the array of activities is nil, then there should only be one row: the header.
        // otherwise, there is the header row AND all of the activities (hence the count + 1)
        return activities == nil ? 1 : activities!.count + 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // retrieve the respective cell from the table view
        let cell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as!ActivityHistoryTableViewCell
        
        // the first row should be the header row
        if indexPath.row == 0 {
            cell.durationLabel.text = "Duration"
            cell.distanceLabel.text = "Distance"
            cell.calorieLabel.text = "Calories"
            cell.dateLabel.text = "Date"
            cell.exerciseType.image = nil
            return cell
        }
        
        if let activity = activities?[indexPath.row - 1] {
            cell.exerciseType.image = UIImage(named: activity.getExerciseType().rawValue)
            cell.durationLabel.text = Converter.timeIntervalToString(activity.getDuration())
            cell.distanceLabel.text = Converter.doubleToString(activity.getDistance())
            cell.calorieLabel.text = Converter.doubleToString(activity.getCaloriesBurned())
            cell.dateLabel.text = Converter.dateToString(activity.getStartTime(), format: "yyyy-MM-dd")
        }
        
        return cell
    }
    
}