//
//  listCollectionViewCell.swift
//  HappyDay
//
//  Created by Panda Star on 1/14/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

class listCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var markImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
