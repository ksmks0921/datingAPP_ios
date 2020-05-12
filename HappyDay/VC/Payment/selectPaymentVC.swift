//
//  selectPaymentVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/22/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

class selectPaymentVC: BottomPopupViewController {
    
    var height: CGFloat?
    var topCornerRadius: CGFloat?
    var presentDuration: Double?
    var dismissDuration: Double?
    var shouldDismissInteractivelty: Bool?
    var delegate: paymentFunctionDelegate?

    @IBOutlet weak var creditCardselectView: DesinableView!
  
    @IBOutlet weak var paypalselectView: DesinableView!
    
    @IBOutlet weak var KonbiniSelectView: DesinableView!
    @IBOutlet weak var googleSelectView: DesinableView!
    
    override func getPopupHeight() -> CGFloat {
          return height ?? CGFloat(600)
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
        
       
        
        
        let tapGesture_1 = UITapGestureRecognizer(target: self, action: #selector(cashBtnTapped(_:)))
        tapGesture_1.delegate = self as? UIGestureRecognizerDelegate
        creditCardselectView.addGestureRecognizer(tapGesture_1)
        
        let tapGesture_2 = UITapGestureRecognizer(target: self, action: #selector(paypalBtnTapped(_:)))
        tapGesture_2.delegate = self as? UIGestureRecognizerDelegate
        paypalselectView.addGestureRecognizer(tapGesture_2)
        
        let tapGesture_3 = UITapGestureRecognizer(target: self, action: #selector(googleBtnTapped(_:)))
        tapGesture_3.delegate = self as? UIGestureRecognizerDelegate
        googleSelectView.addGestureRecognizer(tapGesture_3)
        
        let tapGesture_4 = UITapGestureRecognizer(target: self, action: #selector(konbiniBtnTapped(_:)))
        tapGesture_4.delegate = self as? UIGestureRecognizerDelegate
        KonbiniSelectView.addGestureRecognizer(tapGesture_4)
        
          
      }
    
      @objc func cashBtnTapped(_ sender: DesinableView){
        dismiss(animated: true, completion: nil)
        self.delegate?.continueBtnTappedDismiss(status: "by_cash")
      }
      @objc func paypalBtnTapped(_ sender: DesinableView){
        dismiss(animated: true, completion: nil)
        self.delegate?.continueBtnTappedDismiss(status: "by_paypal")
      }
      @objc func googleBtnTapped(_ sender: DesinableView){
        dismiss(animated: true, completion: nil)
        self.delegate?.continueBtnTappedDismiss(status: "by_google")
      }
      @objc func konbiniBtnTapped(_ sender: DesinableView){
        dismiss(animated: true, completion: nil)
        self.delegate?.continueBtnTappedDismiss(status: "by_konbini")
      }
      @IBAction func backBtnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
      }

    
}
