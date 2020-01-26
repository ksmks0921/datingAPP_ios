//
//  largeCollectionViewCell.swift
//  HappyDay
//
//  Created by Panda Star on 1/14/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

class largeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var otherDescription: UILabel!
    @IBOutlet weak var age: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        image.roundedImage()
//        image.layer.masksToBounds = true
//        image.layer.cornerRadius = image.bounds.width / 2
    }

}
