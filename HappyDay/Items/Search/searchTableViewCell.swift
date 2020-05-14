//
//  searchTableViewCell.swift
//  HappyDay
//
//  Created by Panda Star on 1/14/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

class searchTableViewCell: UITableViewCell {

    @IBOutlet weak var property: UILabel!
    @IBOutlet weak var value: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
