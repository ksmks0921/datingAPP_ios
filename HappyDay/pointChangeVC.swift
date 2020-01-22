//
//  pointChangeVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/21/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

class pointChangeVC: UIViewController {

    @IBOutlet weak var poinBalanceLabel: UILabel!
    @IBOutlet weak var changeBtn_1: UIButton!
    @IBOutlet weak var changeBtn_2: UIButton!
    @IBOutlet weak var changeBtn_3: UIButton!
    @IBOutlet weak var changeBtn_4: UIButton!
    @IBOutlet weak var pointerAddBtn: UIButton!
    @IBOutlet weak var pointerChangeBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
       
                
    }
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func pointerAddBtnTapped(_ sender: Any) {
       
    }
    @IBAction func pointerChangeBtnTapped(_ sender: Any) {
        
        
    }
    @IBAction func changeBtn_1_Tapped(_ sender: Any) {
        guard let popupVC = storyboard?.instantiateViewController(withIdentifier: "paymentStartVC") as? paymentStartVC else { return }
        popupVC.height = 350
        popupVC.topCornerRadius = 10
        popupVC.presentDuration = 1
        popupVC.dismissDuration = 1
        popupVC.shouldDismissInteractivelty = true

        present(popupVC, animated: true, completion: nil)
    }
    @IBAction func changeBtn_2_tapped(_ sender: Any) {
        guard let popupVC = storyboard?.instantiateViewController(withIdentifier: "paymentStartVC") as? paymentStartVC else { return }
        popupVC.height = 350
        popupVC.topCornerRadius = 10
        popupVC.presentDuration = 1
        popupVC.dismissDuration = 1
        popupVC.shouldDismissInteractivelty = true

        present(popupVC, animated: true, completion: nil)
    }
    @IBAction func changeBtn_3_Tapped(_ sender: Any) {
        
    }
    @IBAction func changeBtn_4_Tapped(_ sender: Any) {
        
    }
    
    


}
