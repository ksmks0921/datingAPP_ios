//
//  pointChangeVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/21/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

protocol paymentFunctionDelegate
{
    func continueBtnTappedDismiss(status: String)

}

class pointChangeVC: BaseVC {

    @IBOutlet weak var poinBalanceLabel: UILabel!
    @IBOutlet weak var changeBtn_1: UIButton!
    @IBOutlet weak var changeBtn_2: UIButton!
    @IBOutlet weak var changeBtn_3: UIButton!
    @IBOutlet weak var changeBtn_4: UIButton!
    @IBOutlet weak var pointerAddBtn: UIButton!
    @IBOutlet weak var pointerChangeBtn: UIButton!
    
    
    
    var status: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    override func viewDidDisappear(_ animated: Bool) {
    
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
          
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
       
        if DataManager.isLockScreen {
            NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        }
        else {
            NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
        }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    @objc func applicationDidBecomeActive(notification:NSNotification){
       
           let VC = self.storyboard?.instantiateViewController(withIdentifier: "ScreenLockVC") as! ScreenLockVC
           navigationController?.pushViewController(VC, animated: true)

    }
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func pointerAddBtnTapped(_ sender: Any) {
        pointerAddBtn.backgroundColor = default_green_color
        pointerAddBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        pointerChangeBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        pointerChangeBtn.setTitleColor(default_green_color, for: .normal)

//        footView.isHidden = false
    }
    @IBAction func pointerChangeBtnTapped(_ sender: Any) {
        pointerChangeBtn.backgroundColor = default_green_color
        pointerChangeBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        pointerAddBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        pointerAddBtn.setTitleColor(default_green_color, for: .normal)
        
    }
    @IBAction func changeBtn_1_Tapped(_ sender: Any) {
        guard let popupVC = storyboard?.instantiateViewController(withIdentifier: "paymentStartVC") as? paymentStartVC else { return }
        popupVC.height = 350
        popupVC.topCornerRadius = 10
        popupVC.presentDuration = 1
        popupVC.dismissDuration = 1
        popupVC.shouldDismissInteractivelty = true
        popupVC.delegate = self
        popupVC.popupDelegate = self
        present(popupVC, animated: true, completion: nil)
    }
    @IBAction func changeBtn_2_tapped(_ sender: Any) {
        guard let popupVC = storyboard?.instantiateViewController(withIdentifier: "paymentStartVC") as? paymentStartVC else { return }
        popupVC.height = 350
        popupVC.topCornerRadius = 10
        popupVC.presentDuration = 1
        popupVC.dismissDuration = 1
        popupVC.shouldDismissInteractivelty = true
        popupVC.popupDelegate = self
        present(popupVC, animated: true, completion: nil)
    }
    @IBAction func changeBtn_3_Tapped(_ sender: Any) {
        
    }
    @IBAction func changeBtn_4_Tapped(_ sender: Any) {
        
    }
    
    


}
extension pointChangeVC: BottomPopupDelegate {
  
    func bottomPopupViewLoaded() {
        
        print("bottomPopupViewLoaded")
        
    }
    
    func bottomPopupWillAppear() {
        print("bottomPopupWillAppear")
    }
    
    func bottomPopupDidAppear() {
        
        
        print("bottomPopupDidAppear")
    }
    
    func bottomPopupWillDismiss() {
        print("bottomPopupWillDismiss")
    }
    
    func bottomPopupDidDismiss() {
        
        print("bottomPopupDidDismiss")
    }
    
    func bottomPopupDismissInteractionPercentChanged(from oldValue: CGFloat, to newValue: CGFloat) {
        print("bottomPopupDismissInteractionPercentChanged fromValue: \(oldValue) to: \(newValue)")
    }
}
extension pointChangeVC: paymentFunctionDelegate {
    func continueBtnTappedDismiss(status: String) {
        print(status)
        if status == "continue" {
            guard let popupVC = storyboard?.instantiateViewController(withIdentifier: "selectPaymentVC") as? selectPaymentVC else { return }
            popupVC.height = 600
            popupVC.topCornerRadius = 10
            popupVC.presentDuration = 1
            popupVC.dismissDuration = 1
            popupVC.shouldDismissInteractivelty = true
            popupVC.delegate = self
            popupVC.popupDelegate = self
            present(popupVC, animated: true, completion: nil)
        }
        else if status == "by_cash" {
            guard let popupVC = storyboard?.instantiateViewController(withIdentifier: "paymentConfirmVC") as? paymentConfirmVC else { return }
            popupVC.height = 340
            popupVC.topCornerRadius = 10
            popupVC.presentDuration = 1
            popupVC.dismissDuration = 1
            popupVC.shouldDismissInteractivelty = true
            popupVC.delegate = self
            popupVC.popupDelegate = self
            present(popupVC, animated: true, completion: nil)
        }
        else if status == "by_paypal" {
            guard let popupVC = storyboard?.instantiateViewController(withIdentifier: "paymentConfirmVC") as? paymentConfirmVC else { return }
            popupVC.height = 340
            popupVC.topCornerRadius = 10
            popupVC.presentDuration = 1
            popupVC.dismissDuration = 1
            popupVC.shouldDismissInteractivelty = true
            popupVC.delegate = self
            popupVC.popupDelegate = self
            present(popupVC, animated: true, completion: nil)
        }
        else if status == "by_google" {
            guard let popupVC = storyboard?.instantiateViewController(withIdentifier: "paymentConfirmVC") as? paymentConfirmVC else { return }
            popupVC.height = 340
            popupVC.topCornerRadius = 10
            popupVC.presentDuration = 1
            popupVC.dismissDuration = 1
            popupVC.shouldDismissInteractivelty = true
            popupVC.delegate = self
            popupVC.popupDelegate = self
            present(popupVC, animated: true, completion: nil)
        }
        else if status == "by_konbini" {
            guard let popupVC = storyboard?.instantiateViewController(withIdentifier: "paymentConfirmVC") as? paymentConfirmVC else { return }
            popupVC.height = 340
            popupVC.topCornerRadius = 10
            popupVC.presentDuration = 1
            popupVC.dismissDuration = 1
            popupVC.shouldDismissInteractivelty = true
            popupVC.delegate = self
            popupVC.popupDelegate = self
            present(popupVC, animated: true, completion: nil)
        }
    }
    
    
}
