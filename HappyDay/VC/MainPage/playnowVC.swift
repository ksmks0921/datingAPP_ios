//
//  playnowVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/16/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

class playnowVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
 
    }
    @IBAction func backBtnTapped(_ sender: Any) {
           self.navigationController?.popViewController(animated: true)
    }
       
   override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       
       navigationController?.setNavigationBarHidden(true, animated: animated)
      
               
   }
    @IBAction func messageBtnTapped(_ sender: Any) {
//        let VC = self.storyboard?.instantiateViewController(withIdentifier: "chatRoomVC") as! chatRoomVC
//        navigationController?.pushViewController(VC, animated: true)
        navigationController?.pushViewController(AdvancedExampleViewController(), animated: true)
    }
    @IBAction func otherBtnTapped(_ sender: Any) {
    }
    @IBAction func memoBtnTapped(_ sender: Any) {
    }
    


}
