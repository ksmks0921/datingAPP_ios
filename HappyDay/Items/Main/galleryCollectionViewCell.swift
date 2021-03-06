//
//  galleryCollectionViewCell.swift
//  HappyDay
//
//  Created by Panda Star on 1/14/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

@available(iOS 11.0, *)
class galleryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
  
    @IBOutlet weak var region: UILabel!
    @IBOutlet weak var age: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
//        // Initialization code
//        image.roundedImage()
        image.layer.cornerRadius = 8
        image.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

}
