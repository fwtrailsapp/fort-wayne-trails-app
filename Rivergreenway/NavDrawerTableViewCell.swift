//
//  NavDrawerTableViewCell.swift
//  Rivergreenway
//
//  Created by Scott Weidenkopf on 2/10/16.
//  Copyright © 2016 City of Fort Wayne Rivergreenways and Trails Department. All rights reserved.
//

import UIKit

class NavDrawerTableViewCell: UITableViewCell {

    //  MARK: - View Components
    @IBOutlet weak var cellIcon: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
