//
//  alarmViewCell.swift
//  HappyDay
//
//  Created by Crystal Abarientos on 5/19/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

class alarmViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
