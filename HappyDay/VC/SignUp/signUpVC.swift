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

class signUpVC: BaseVC {

    let domains: [String] = ["Horse", "Cow", "Camel", "Sheep", "Goat"]
    var selectedElement = [Int : String]()
    @IBOutlet weak var womanBtn: UIButton!
    @IBOutlet weak var manBtn: UIButton!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var regionUIView: DesinableView!
    @IBOutlet weak var ageUIView: DesinableView!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var passwordAgainTxt: UITextField!
 
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
        
        if DataManager.isLogin! {
            
            
            
        } else {
            UserVM.shared.AnonymousLogin{(success, message, error) in
                if error == nil {

                           SettingVM.shared.getSelectingAges(completion: {_ in
                                self.AgeList = SettingVM.AgeList
                           })
                           SettingVM.shared.getSelectingRegions(completion: {_ in
                                self.RegionList = SettingVM.RegionList
                           })

                }else {
                    self.showAlert(message: "_____error____")
                }
        }
       
                   
    }
       
        
        
        
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
               popupVC.height = CGFloat(self.RegionList.count * 60 + 70)
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
             popupVC.height = CGFloat(self.AgeList.count * 60 + 70)
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
        manBtn.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
        manBtn.setImage(selectedImage, for: .normal)
        womanBtn.setImage(nil, for: .normal)
        womanBtn.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        self.gender = true
    }
    @IBAction func womanSelect(_ sender: Any) {
        womanBtn.backgroundColor = #colorLiteral(red: 0.2078431373, green: 0.6784313725, blue: 0.7450980392, alpha: 1)
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
                return "암호를 확인하세요."
            }
            if emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                return "빈칸을 채워주세요."
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
            UserVM.shared.singUp(email: emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines), password: passwordTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines), city: regionLabel.text!, gender: gender, age: ageLabel.text!) { (success, message, error) in
                
               Indicator.sharedInstance.hideIndicator()
               if error == nil{
                   if success{
                       DataManager.isLogin = true
                       DataManager.isShowingSearchResult = false
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
