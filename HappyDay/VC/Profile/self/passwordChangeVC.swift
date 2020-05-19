//
//  friendListVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/18/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

class passwordChangeVC: BaseVC {
    
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var passwordAgainText: UITextField!
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
    
    @IBAction func saveBtnTapped(_ sender: Any) {
        if passwordText.text != "" {
            if passwordAgainText.text == passwordText.text {
               savePassword()
            }
            else {
               self.showAlert(message: "암호를 확인하세요.")
            }
        }
        else {
            self.showAlert(message: "암호를 확인하세요.")
        }
    }
    
    func savePassword() {
        UserVM.shared.updatePassword(newPass: passwordText.text!) {(success, message, error) in
            
            self.showAlert(message: message)
            self.passwordText.text = ""
            self.passwordAgainText.text = ""
            
        }
    }
}
