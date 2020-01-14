//
//  UIImageView.swift
//  HappyDay
//
//  Created by Panda Star on 1/14/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {

    func roundedImage() {

//        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
//        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.width  / 2
        self.clipsToBounds = true
    }
}
