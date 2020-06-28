//
//  BottomBorderClass.swift
//  HappyDay
//
//  Created by Crystal Abarientos on 6/27/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import Foundation
import UIKit

class BottomBorderClass: UILabel {


  required init(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)!
      self.setBottomBorder()
  }

  override init(frame: CGRect) {
      super.init(frame:frame)
      self.setBottomBorder()
  }

  func setBottomBorder()
  {

      let borderWidth:CGFloat = 1.0 //Change this according to your needs
      let lineView = UIView.init(frame: CGRect.init(x: 0, y:self.frame.size.height - borderWidth , width: self.frame.size.width, height: borderWidth))
      lineView.backgroundColor = UIColor.white
      self.addSubview(lineView)

  }
}
