//
//  postTableViewCell.swift
//  HappyDay
//
//  Created by Panda Star on 1/15/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

class postTableViewCell: UITableViewCell {

 
    
    @IBOutlet weak var hobbyLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var age_region_label: UILabel!
    @IBOutlet weak var textContentLabel: UILabel!
    @IBOutlet weak var personPhoto: UIImageView!
    @IBOutlet weak var views: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
         personPhoto.roundedImage()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
