//
//  loginVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/13/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

protocol loginVCDelegate
{
    func selectDomainDismiss(domain: String)
}



class loginVC: BaseVC {

    @IBOutlet weak var gotodomain: UIView!
    @IBOutlet weak var domainLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    var domain: String?
    @IBOutlet weak var emailTextField: UITextField!
     @IBOutlet weak var ScrollContent: UIScrollView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
     
        
        //select domain function
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectDomain(_:)))
        tapGesture.delegate = self as? UIGestureRecognizerDelegate
        gotodomain.addGestureRecognizer(tapGesture)
        
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
    
    @objc func selectDomain(_ sender: UIView) {
       let VC = self.storyboard?.instantiateViewController(withIdentifier: "selectDomainVC") as! selectDomainVC
       VC.delegate = self
       VC.page_from = "login"
       navigationController?.pushViewController(VC, animated: true)
    }

    @IBAction func facebookLogin(_ sender: Any) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "facebookLoginVC") as! facebookLoginVC
        navigationController?.pushViewController(VC, animated: true)
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
                                
                                self.getPoints()
                                self.getLikes()
                                self.getMemos()
                                self.getIgnores()
                                self.getBlocks()
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
    
    func getPoints() {
        UserVM.shared.getPoint(user_id: DataManager.userId!, completion: {_ in
            DataManager.points = UserVM.user_points
        })
    }
    func getRegions() {
        UserVM.shared.getLikes(user_id: DataManager.userId!, completion: {_ in
            print("Likes added successfully!")
        })
    }
    func getLikes() {
        UserVM.shared.getLikes(user_id: DataManager.userId!, completion: {_ in
            print("Likes added successfully!")
        })
    }
    func getMemos() {
        UserVM.shared.getMemos(user_id: DataManager.userId!, completion: {_ in
            print("Memos added successfully!")
        })
    }
    func getIgnores() {
        UserVM.shared.getIgnores(user_id: DataManager.userId!, completion: {_ in
            print("Ignores added successfully!")
        })
    }
    func getBlocks() {
        UserVM.shared.getBlocks(user_id: DataManager.userId!, completion: {_ in
            print("Blocks added successfully!")
        })
    }
}

extension loginVC: loginVCDelegate {
    
    func selectDomainDismiss(domain: String) {
        self.domainLabel.text = domain
    }
    
    
}


