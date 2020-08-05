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
        passwordText.delegate = self
        passwordAgainText.delegate = self
        
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
        Indicator.sharedInstance.showIndicator()
        UserVM.shared.updatePassword(newPass: passwordText.text!) {(success, message, error) in
            DataManager.password = self.passwordText.text
            let user = UserVM.current_user
            let sex = { () -> Bool in
                if user!.user_sex == "男性" {
                    return true
                }
                else {
                    return false
                }
            }
            
            UserVM.shared.updateUserData(city: user!.user_city!, age: user!.user_age!, job: user!.user_job!, blood: user!.user_blood!, star: user!.user_star!, tall: user!.user_tall!, user_style: user!.user_style!, life_style: user!.user_lifestyle!, user_outside: user!.user_outside!, sex: sex(), nick_name: user!.user_nickName!, style_1: user!.style_1!, style_2: user!.style_2!, style_3: user!.style_3!, style_4: user!.style_4!, require_age: user!.required_age!, is_approved: user!.is_approved!, updated_at: user!.updated_at!, created_at: user!.created_at!, require_style: user!.require_style!, require_tall: user!.require_tall!, status: user!.user_status!, introduce: (user?.user_introduce)!, date: user!.user_date!, user_avatar: user!.user_avatar!) {(success, message, error) in
                Indicator.sharedInstance.hideIndicator()
                if error == nil {
                    if success {
                        self.showAlert(message: "パスワードが成功裏に変更されました。")
                        
                        self.passwordText.text = ""
                        self.passwordAgainText.text = ""
                    }
                    else {
                        self.showAlert(message: "error")
                    }
                }
                else {
                    print(error)
                }
                
            }
            
            
            
            
            
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
        return updatedText.count <= 6
    }

   
}
