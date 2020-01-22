//
//  paymentStartVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/21/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit



class paymentStartVC: BottomPopupViewController {

    var height: CGFloat?
    var topCornerRadius: CGFloat?
    var presentDuration: Double?
    var dismissDuration: Double?
    var shouldDismissInteractivelty: Bool?
    var location: String?
    var delegate: paymentFunctionDelegate?
    var location_age: String?
    
    @IBOutlet weak var continueBtnTapped: UIButton!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func continueBtnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        delegate?.continueBtnTappedDismiss(status: "continue")
    }
}
