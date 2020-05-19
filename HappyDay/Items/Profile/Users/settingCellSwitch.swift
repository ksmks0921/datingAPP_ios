//
//  settingCellSwitch.swift
//  HappyDay
//
//  Created by Crystal Abarientos on 5/19/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

class settingCellSwitch: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var switchButton: UISwitch!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        switchButton.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
