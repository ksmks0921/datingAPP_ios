//
//  postTableViewCell.swift
//  HappyDay
//
//  Created by Panda Star on 1/15/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

class postTableViewCell: UITableViewCell {

   
    @IBOutlet weak var personPhoto: UIImageView!
    @IBOutlet weak var hopeType: UILabel!
    @IBOutlet weak var hopeTypeBack: DesinableView!
    @IBOutlet weak var start: UIImageView!
    @IBOutlet weak var star: UIImageView!
    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var age_location: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var views: UILabel!
    @IBOutlet weak var newOrNot: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
