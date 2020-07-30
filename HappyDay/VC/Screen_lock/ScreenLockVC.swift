//
//  ScreenLockVC.swift
//  HappyDay
//
//  Created by Crystal Abarientos on 6/23/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

class ScreenLockVC: BaseVC , UITextFieldDelegate{

    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
       
            let maxLength = 6
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
       
    }
    override func viewWillAppear(_ animated: Bool) {
             super.viewWillAppear(animated)
             navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    @IBAction func confirmButtonTapped(_ sender: Any) {
        
        if DataManager.password == passwordTextField.text {
            self.navigationController?.popViewController(animated: true)
        }
        else {
            self.showAlert(message: "パスワード確認入力")
        }
    }


}
