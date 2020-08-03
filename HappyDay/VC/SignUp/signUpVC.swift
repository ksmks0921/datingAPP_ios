//
//  signUpVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/13/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth


protocol PopUpDelegate
{
    func PopupWillDismissForData(data: String)
    
}

class signUpVC: BaseVC , UITextFieldDelegate{

    var domains : [String]!
    var selectedElement = [Int : String]()
    @IBOutlet weak var womanBtn: UIButton!
    @IBOutlet weak var manBtn: UIButton!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var regionUIView: DesinableView!
    @IBOutlet weak var ageUIView: DesinableView!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var passwordAgainTxt: UITextField!
    @IBOutlet weak var nickNameText: UITextField!
    @IBOutlet weak var contentScroll : UIScrollView!
    var gender = true
    var selectedImage = UIImage(named: "sharp_check_white_18dp")?.withRenderingMode(.alwaysTemplate)
    var location: String?
    var age:String?
    @IBOutlet weak var emailTextField: UITextField!
    var AgeList = [String]()
    var RegionList = [String]()
    var selected_item: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        setUpViewClick()
        passwordAgainTxt.delegate = self
        passwordTxt.delegate = self
        emailTextField.delegate = self
        nickNameText.delegate = self
            if DataManager.isLogin! {
                
                
                
            } else {
                UserVM.shared.AnonymousLogin{(success, message, error) in
                    if error == nil {

                               SettingVM.shared.getSelectingAges(completion: {_ in
                                    self.AgeList = SettingVM.AgeList
                                    self.ageLabel.text = self.AgeList[0]
                                    
                               })
                               SettingVM.shared.getSelectingRegions(completion: {_ in
                                    self.RegionList = SettingVM.RegionList
                                    self.regionLabel.text = self.RegionList[0]
                               })
                               

                    }else {
                        self.showAlert(message: "_____error____")
                    }
                }
      
            }
            if AgeList.count > 0 {
                self.ageLabel.text = self.AgeList[0]
            }
            if RegionList.count > 0 {
                self.regionLabel.text = self.RegionList[0]
            }
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
        
        
        
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == passwordTxt || textField == passwordAgainTxt {
            let maxLength = 6
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        else {
            let maxLength = 100
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
    }
    @objc func keyboardWillShow(notification:NSNotification){

        let userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)

        var contentInset:UIEdgeInsets = self.contentScroll.contentInset
        contentInset.bottom = keyboardFrame.size.height + 20
        contentScroll.contentInset = contentInset
    }

    @objc func keyboardWillHide(notification:NSNotification){

        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        contentScroll.contentInset = contentInset
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           self.view.endEditing(true)
           return false
    }
    func setUpViewClick() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(clickView_1(_:)))
        tapGesture.delegate = self as? UIGestureRecognizerDelegate
        regionUIView.addGestureRecognizer(tapGesture)
        
        let tapGesture_1 = UITapGestureRecognizer(target: self, action: #selector(clickView_2(_:)))
        tapGesture_1.delegate = self as? UIGestureRecognizerDelegate
        ageUIView.addGestureRecognizer(tapGesture_1)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           
           navigationController?.setNavigationBarHidden(true, animated: animated)
                   
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func clickView_1(_ sender: UIView) {
        
        SettingVM.shared.getSelectingRegions(completion: {_ in
            self.selected_item = 0
            self.RegionList = SettingVM.RegionList
            guard let popupVC = self.storyboard?.instantiateViewController(withIdentifier: "BottomeSelectVC") as? BottomeSelectVC else { return }
            
               let height_view = self.view.frame.size.height
               let height_bottom_view = (SettingVM.RegionList.count + 1) * 60
               if height_bottom_view > Int(height_view) {
                   popupVC.height = CGFloat(height_view - 80)
               }
               else {
                   popupVC.height = CGFloat(height_bottom_view)
               }
               
            
               popupVC.topCornerRadius = 10
               popupVC.presentDuration = 1
               popupVC.dismissDuration = 1
               popupVC.shouldDismissInteractivelty = true
               popupVC.popupDelegate = self
               popupVC.delegate = self
            
               popupVC.items = self.RegionList
            self.present(popupVC, animated: true, completion: nil)
        })
          
        
    }
    @objc func clickView_2(_ sender: UIView) {
        SettingVM.shared.getSelectingAges(completion: {_ in
           
             self.AgeList = SettingVM.AgeList
             self.selected_item = 1
             guard let popupVC = self.storyboard?.instantiateViewController(withIdentifier: "BottomeSelectVC") as? BottomeSelectVC else { return }
             let height_view = self.view.frame.size.height
             let height_bottom_view = (SettingVM.AgeList.count + 1) * 60
             if height_bottom_view > Int(height_view) {
                 popupVC.height = CGFloat(height_view - 80)
             }
             else {
                 popupVC.height = CGFloat(height_bottom_view)
             }
             popupVC.topCornerRadius = 10
             popupVC.presentDuration = 1
             popupVC.dismissDuration = 1
             popupVC.shouldDismissInteractivelty = true
             popupVC.popupDelegate = self
             popupVC.delegate = self
    
             popupVC.items = self.AgeList
             self.present(popupVC, animated: true, completion: nil)
        })
          
        
    }
    @IBAction func manSelect(_ sender: Any) {
        manBtn.backgroundColor = #colorLiteral(red: 0.2588235294, green: 0.7294117647, blue: 0.1058823529, alpha: 1)
        manBtn.setImage(selectedImage, for: .normal)
        womanBtn.setImage(nil, for: .normal)
        womanBtn.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
       
        self.gender = true
    }
    @IBAction func womanSelect(_ sender: Any) {
        womanBtn.backgroundColor = #colorLiteral(red: 0.2588235294, green: 0.7294117647, blue: 0.1058823529, alpha: 1)
        womanBtn.setImage(selectedImage, for: .normal)
        manBtn.setImage(nil, for: .normal)
        manBtn.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        self.gender = false
    }
    
    @IBAction func goNextBtn(_ sender: Any) {
        
        signUp()
        
    }
 
    
}

extension signUpVC {
    
        func validateFields() -> String? {
            if passwordTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) != passwordAgainTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
                passwordTxt.textColor = #colorLiteral(red: 0.7450980392, green: 0.04899250873, blue: 0, alpha: 1)
                passwordAgainTxt.textColor = #colorLiteral(red: 0.7450980392, green: 0.04899250873, blue: 0, alpha: 1)
                return "パスワード確認入力"
            }
            if emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                return "Please fill the field"
            }
            if nickNameText.text == nil || nickNameText.text == "" {
                return "ニックネームを選択してください"
            }
            if regionLabel.text == "" || regionLabel.text == nil {
                return "地域を選択してください"
            }
            if ageLabel.text == "" || regionLabel.text == nil {
                return "年齢を選択してください"
            }
            
            
    //        let cleanPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    //        if UserVM.isPasswordValid(cleanPassword) == false {
    //            return "Please make sure your password is at least 8 characters, contains a special character and a number"
    //        }
            return nil
            
            
            
    }
    
    func signUp() {
        
        let error = validateFields()
        if error != nil {
            self.showAlert(message: error)
        }
        else {
            Indicator.sharedInstance.showIndicator()
            UserVM.shared.singUp(email: emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines), password: passwordTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines), city: regionLabel.text!, gender: gender, age: ageLabel.text!, nickName: nickNameText.text!) { (success, message, error) in
                
               Indicator.sharedInstance.hideIndicator()
               if error == nil{
                   if success{
                       DataManager.isLogin = true
                       DataManager.isShowingSearchResult = false
                       DataManager.email = self.emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                       DataManager.password = self.passwordTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                       SettingVM.shared.getPoints()
                       SettingVM.shared.getLikes()
                       SettingVM.shared.getMemos()
                       SettingVM.shared.getIgnores()
                       SettingVM.shared.getBlocks()
                       let VC = self.storyboard?.instantiateViewController(withIdentifier: "customTabBarVC") as! customTabBarVC
                       self.navigationController?.pushViewController(VC, animated: true)
                   }else{
                       self.showAlert(message: message)
                   }
               }else{
                   self.showAlert(message: error?.localizedDescription)
               }
                
           }
            
        }
    }// end of signUp function
    
}




extension signUpVC: BottomPopupDelegate {
  
    func bottomPopupViewLoaded() {
        
        print("bottomPopupViewLoaded")
        
    }
    
    func bottomPopupWillAppear() {
        print("bottomPopupWillAppear")
    }
    
    func bottomPopupDidAppear() {       
        
        
        print("bottomPopupDidAppear")
    }
    
    func bottomPopupWillDismiss() {
        print("bottomPopupWillDismiss")
    }
    
    func bottomPopupDidDismiss() {
        
        print("bottomPopupDidDismiss")
    }
    
    func bottomPopupDismissInteractionPercentChanged(from oldValue: CGFloat, to newValue: CGFloat) {
        print("bottomPopupDismissInteractionPercentChanged fromValue: \(oldValue) to: \(newValue)")
    }
}


extension signUpVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return self.domains.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

       let cell = tableView.dequeueReusableCell(withIdentifier: "MyCustomCell", for: indexPath as IndexPath) as! CustomTableViewCell
       cell.label?.text = self.domains[indexPath.row]
       let item = domains[indexPath.row]

       if item == selectedElement[indexPath.row] {
          cell.radioBtn.isSelected = true
       } else {
          cell.radioBtn.isSelected = false
       }
       cell.initCellItem()
       return cell

    }
    
    
}

extension signUpVC: PopUpDelegate {
    
    func PopupWillDismissForData(data: String) {
        if self.selected_item == 0 {
            self.regionLabel.text = data
           
        }
        else {
            self.ageLabel.text = data
        }

    }
    
    

        
}
