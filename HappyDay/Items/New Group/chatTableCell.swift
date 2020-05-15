//
//  chatTableCell.swift
//  HappyDay
//
//  Created by Panda Star on 1/16/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

class chatTableCell: UITableViewCell {

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var status_icon: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var age_region_label: UILabel!
    @IBOutlet weak var statusView: DesinableView!
    @IBOutlet weak var last_chat_label: UILabel!
    @IBOutlet weak var time_label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        photo.roundedImage()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
