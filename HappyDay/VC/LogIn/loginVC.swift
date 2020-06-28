//
//  loginVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/13/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit




class loginVC: BaseVC , UITextFieldDelegate{

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var ScrollContent: UIScrollView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
  

        emailTextField.delegate = self
        passwordTextField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)

    }
    
    @objc func keyboardWillShow(notification:NSNotification){

       let userInfo = notification.userInfo!
       var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
       keyboardFrame = self.view.convert(keyboardFrame, from: nil)

       var contentInset:UIEdgeInsets = self.ScrollContent.contentInset
       contentInset.bottom = keyboardFrame.size.height + 20
       ScrollContent.contentInset = contentInset
   }

   @objc func keyboardWillHide(notification:NSNotification){

       let contentInset:UIEdgeInsets = UIEdgeInsets.zero
       ScrollContent.contentInset = contentInset
   }
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           self.view.endEditing(true)
           return false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
       
                
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
           return .lightContent
    }

    @IBAction func backBtnTapped(_ sender: Any) {
           self.navigationController?.popViewController(animated: true)
    }
    
  
 
    @IBAction func login(_ sender: Any) {
        
        login()
       
        
    }
    
  
    

}
extension loginVC {
    
    func validateFields() -> String? {
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields"
        }
        
//        let cleanPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//        if UserVM.isPasswordValid(cleanPassword) == false {
//            return "Please make sure your password is at least 8 characters, contains a special character and a number"
//        }
        else {
             return nil
        }
       
        
        
        
    }
    
    func login() {
        let error = validateFields()
        if error != nil {
            self.showAlert(message: error)
        }
        else {
            Indicator.sharedInstance.showIndicator()
            UserVM.shared.login(email: emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines), password: passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)) { (success, message, error) in
                       if error == nil{
                           if success{
                                Indicator.sharedInstance.hideIndicator()
                                DataManager.isLogin = true
                                DataManager.isShowingSearchResult = false
                                DataManager.email = self.emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                                DataManager.password = self.passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                            
                                SettingVM.shared.getPoints()
                                SettingVM.shared.getLikes()
                                SettingVM.shared.getMemos()
                                SettingVM.shared.getIgnores()
                                SettingVM.shared.getBlocks()
                                let VC = self.storyboard?.instantiateViewController(withIdentifier: "customTabBarVC") as! customTabBarVC
                                self.navigationController?.pushViewController(VC, animated: true)
                                
                            
                            
                            } else {
                                self.showAlert(message: message)
                            }
                        
                    }else {
                        self.showAlert(message: message)
                    }
            }
        }

    }
    
    
}



