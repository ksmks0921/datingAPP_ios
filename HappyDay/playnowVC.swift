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
        
        navigationController?.hidesBarsOnTap = false
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
        UINavigationBar.appearance().tintColor = UIColor.white
        self.title = "지금부터 놀자"
        let backButton = UIBarButtonItem()
        backButton.title = "뒤로"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
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
