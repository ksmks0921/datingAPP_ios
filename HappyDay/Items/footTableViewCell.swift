//
//  footTableViewCell.swift
//  HappyDay
//
//  Created by Panda Star on 1/18/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

class footTableViewCell: UITableViewCell {

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var footDesc: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var newMark: UIImageView!
    @IBOutlet weak var desc: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}