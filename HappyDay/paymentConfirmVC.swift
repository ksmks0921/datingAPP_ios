//
//  paymentConfirmVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/22/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

class paymentConfirmVC: BottomPopupViewController {
    var height: CGFloat?
    var topCornerRadius: CGFloat?
    var presentDuration: Double?
    var dismissDuration: Double?
    var shouldDismissInteractivelty: Bool?
    var delegate: paymentFunctionDelegate?
    
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var elevenSevenBtnTapped: UIButton!
    
    
    override func getPopupHeight() -> CGFloat {
        return height ?? CGFloat(300)
    }
    
    override func getPopupTopCornerRadius() -> CGFloat {
        return topCornerRadius ?? CGFloat(10)
    }
    
    override func getPopupPresentDuration() -> Double {
        return presentDuration ?? 1.0
    }
    
    override func getPopupDismissDuration() -> Double {
        return dismissDuration ?? 1.0
    }
    
    override func shouldPopupDismissInteractivelty() -> Bool {
        return shouldDismissInteractivelty ?? true
    }
    @IBAction func elevenSevenBtnTapped(_ sender: Any) {
        
    }
    @IBAction func lawsonBtnTapped(_ sender: Any) {
        
    }
    @IBAction func famileBtnTapped(_ sender: Any) {
        
    }
    @IBAction func confirmBtnTapped(_ sender: Any) {
        
    }
}
