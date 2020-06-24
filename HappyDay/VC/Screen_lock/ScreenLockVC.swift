//
//  ScreenLockVC.swift
//  HappyDay
//
//  Created by Crystal Abarientos on 6/23/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

class ScreenLockVC: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
             super.viewWillAppear(animated)
             navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    @IBAction func confirmButtonTapped(_ sender: Any) {
        
//        if DataManager.screenLockPass == passwordTextField.text {
            self.navigationController?.popViewController(animated: true)
//        }
        
    }


}
