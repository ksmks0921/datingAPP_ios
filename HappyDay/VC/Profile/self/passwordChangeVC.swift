//
//  friendListVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/18/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

class passwordChangeVC: BaseVC, UITextFieldDelegate{
    
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var passwordAgainText: UITextField!
    var count_password: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewDidDisappear(_ animated: Bool) {
    
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
          
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        passwordText.delegate = self
        if DataManager.isLockScreen {
            NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        }
        else {
            NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
        }
    }
    @objc func applicationDidBecomeActive(notification:NSNotification){
       
           let VC = self.storyboard?.instantiateViewController(withIdentifier: "ScreenLockVC") as! ScreenLockVC
           navigationController?.pushViewController(VC, animated: true)

    }
  
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func saveBtnTapped(_ sender: Any) {
        if passwordText.text != "" {
            if passwordAgainText.text == passwordText.text {
                if count_password < 6 {
                    self.showAlert(message: "半角英数字6文字以上で入力してください")
                }
                else {
                    savePassword()
                }
               
            }
            else {
               self.showAlert(message: "パスワードを再度確認してください")
            }
        }
        else {
            self.showAlert(message: "パスワードを再度確認してください")
        }
    }
    
    func savePassword() {
        UserVM.shared.updatePassword(newPass: passwordText.text!) {(success, message, error) in
            
            self.showAlert(message: message)
            self.passwordText.text = ""
            self.passwordAgainText.text = ""
            
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // get the current text, or use an empty string if that failed
        let currentText = textField.text ?? ""
        let newLength = textField.text?.count
        count_password = newLength
        // attempt to read the range they are trying to change, or exit if we can't
        guard let stringRange = Range(range, in: currentText) else { return false }

        // add their new text to the existing text
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

        // make sure the result is under 16 characters
        return updatedText.count <= 8
    }

   
}
