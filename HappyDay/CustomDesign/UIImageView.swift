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
        self.layer.masksToBounds = true
//        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.width  / 2
        self.clipsToBounds = true
    }
}
extension UIViewController {

    /**
     *  Height of status bar + navigation bar (if navigation bar exist)
     */

    var topbarHeight: CGFloat {
        return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
    var navbarHeight:CGFloat {
        return  self.navigationController?.navigationBar.frame.height ?? 0.0
    }
}
extension UIColor {
    static let primaryColor = UIColor(red: 69/255, green: 193/255, blue: 89/255, alpha: 1)
    static let clearColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0)
}





