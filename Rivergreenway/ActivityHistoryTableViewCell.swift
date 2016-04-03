//
//  ActivityHistoryTableViewCell.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 2/13/16.
//  Copyright © 2016 City of Fort Wayne Greenways and Trails Department. All rights reserved.
//

import UIKit

/**
 A cell in the Activity History table. Each cell displays an activity's
 data: exercise type, duration, distance, calories, and date.
 */
class ActivityHistoryTableViewCell: UITableViewCell {

    // MARK: - View Components
    @IBOutlet weak var exerciseType: UIImageView!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var calorieLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
