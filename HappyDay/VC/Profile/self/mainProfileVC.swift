//
//  mainProfileVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/17/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

class mainProfileVC: BaseVC {

    @IBOutlet weak var finishBtn: UIButton!
   
    @IBOutlet weak var tableView: UITableView!
  
    @IBOutlet weak var settingBtn: UIButton!
    
    
    let properties_profile: [String] = ["닉명", "년령", "성별", "별자리", "피형", "거주지", "외모", "신장", "스타일", "직업", "생활스타일", "멋", "멋쟁이도", "부자도", "부드러움", "상대방에게 요구하는 조건", "년령", "신장", "스타일"]
    var value_profile : [String]!
    var selected_item: Int!
    var user: person!
    override func viewDidLoad() {
        super.viewDidLoad()
        //set title and change back button title
    
        let backButton = UIBarButtonItem()
        backButton.title = "뒤로"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        
        
        let nib_1 = UINib.init(nibName: "searchTableViewCell", bundle: nil)
        self.tableView.register(nib_1, forCellReuseIdentifier: "searchTableViewCell")
        let nib_2 = UINib.init(nibName: "selfEvaluationCell", bundle: nil)
        self.tableView.register(nib_2, forCellReuseIdentifier: "selfEvaluationCell")
        
        if UserVM.current_user != nil {
            user = UserVM.current_user
            value_profile = [user!.user_nickName!, user!.user_age!, user!.user_sex!, user!.user_star!, user!.user_blood!, user!.user_city!,user!.user_outside!, user!.user_tall!, user!.user_style!, user!.user_job!, user!.user_lifestyle!,  user!.style_1!, user!.style_2!, user!.style_3!, user!.style_4!,  "", user!.required_age!, user!.require_tall!, user!.require_style!]
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           
           navigationController?.setNavigationBarHidden(true, animated: animated)
          
                   
    }
    @IBAction func settingBtnTapped(_ sender: Any) {
        
        
    }
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
  
    @IBAction func finishBtnTapped(_ sender: Any) {
        
        let sex = { () -> Bool in
            if self.value_profile[2] == "남자" {
                return true
            }
            else {
                return false
            }
        }
        UserVM.shared.updateUserData(city: value_profile[5], age: value_profile[1], job: value_profile[9], blood: value_profile[4], star: value_profile[3], tall: value_profile[7], user_style: value_profile[8], life_style: value_profile[10], user_outside: value_profile[6], sex: sex(), nick_name: value_profile[0], style_1: value_profile[11], style_2: value_profile[12], style_3: value_profile[13], style_4: value_profile[14], require_age: value_profile[16], is_approved: self.user.is_approved!, updated_at: user.updated_at!, created_at: user!.created_at!, require_style: value_profile[18], require_tall: value_profile[17], status: user!.user_status!, introduce: user!.user_introduce!, date: user!.user_date!, user_avatar: user.user_avatar!) {(success, message, error) in
            if error == nil {
                if success {
                    self.showAlert(message: "성공!")
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
extension mainProfileVC:  UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            return properties_profile.count
       
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 11 || indexPath.row == 12 || indexPath.row == 13 || indexPath.row == 14 {
            
                let cell = tableView.dequeueReusableCell(withIdentifier: "selfEvaluationCell", for: indexPath as IndexPath) as! selfEvaluationCell
                cell.titleLabel.text = self.properties_profile[indexPath.row]
                cell.ratingView.settings.updateOnTouch  = true
                cell.selectionStyle = .none
                cell.titleLabel.textColor = UIColor.darkGray
                cell.ratingView.rating = Double(value_profile[indexPath.row])!
                cell.ratingView.settings.fillMode = .full
                cell.ratingView.didFinishTouchingCosmos = { rating in
                    self.value_profile[indexPath.row] = String(rating)
                }
                    
           
            
                cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                return cell
                
        }
        else {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "searchTableViewCell", for: indexPath as IndexPath) as! searchTableViewCell
            
                cell.property?.text = self.properties_profile[indexPath.row]
            
                if indexPath.row == 0 {
                    cell.inputTextField.isHidden = false
                    cell.inputTextField.text = value_profile[indexPath.row]
                    cell.inputTextField.borderStyle = UITextField.BorderStyle.none
                    cell.value.isHidden = true
                    cell.rightArrowIcon.isHidden = true
                    cell.selectionStyle = .none
                    cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//                    cell.isUserInteractionEnabled = false
                    
                }
                else if indexPath.row == 15 {
                    cell.selectionStyle = .none
                    cell.value.isHidden = true
                    cell.rightArrowIcon.isHidden = true
                    cell.inputTextField.isHidden = true
                    cell.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                }
                else {
                    cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    cell.inputTextField.isHidden = true
                    cell.rightArrowIcon.isHidden = false
                    cell.value.isHidden = false
                    cell.value.text = value_profile[indexPath.row]
                }
                
                

                return cell
        }
            
       
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selected_item = indexPath.row
        if indexPath.row  == 1 {
                
               SettingVM.shared.getSelectingAges(completion: {_ in
                
                        let age_list = SettingVM.AgeList
                
                        self.showSelectView(items: age_list)
                    
                })

        }
        else if indexPath.row == 2 {
            
            showSlectViewWithRadio(items: ["남자", "녀자"])
            
        }
        else if indexPath.row == 3 {
            
            SettingVM.shared.getStars(completion: {_ in
            
                    let star_lsit = SettingVM.StarList
            
                    self.showSelectView(items: star_lsit)
                
            })
        }
        else if indexPath.row == 4 {
            self.showSelectView(items: ["O형", "A형", "B형", "AB형"])
        }
        else if indexPath.row == 5 {
            
            SettingVM.shared.getSelectingRegions(completion: {_ in
            
                    let region_list = SettingVM.RegionList
            
                    self.showSelectView(items: region_list)
                
            })
        }
        else if indexPath.row == 6 {
            
            SettingVM.shared.getOurStyle(completion: {_ in
            
                    let ourStyle_list = SettingVM.OurStyleList
            
                    self.showSelectView(items: ourStyle_list)
                
            })
        }
        else if indexPath.row == 7 {
            
            SettingVM.shared.getTallSetting(completion: {_ in
            
                    let tall_list = SettingVM.TallList
            
                    self.showSlectViewWithRadio(items: tall_list)
                
            })
            
        }
        else if indexPath.row == 8 {
            SettingVM.shared.getStyleSetting(completion: {_ in
            
                    let style_list = SettingVM.StyleList
            
                    self.showSlectViewWithRadio(items: style_list)
                
            })
            
        }
        else if indexPath.row == 9 {
            SettingVM.shared.getJobSetting(completion: {_ in
            
                    let job_list = SettingVM.JobList
            
                    self.showSelectView(items: job_list)
                
            })
        }
        else if indexPath.row == 10 {
            SettingVM.shared.getLifeStyle(completion: {_ in
            
                    let lifestyle_list = SettingVM.LifeStyleList
            
                    self.showSelectView(items: lifestyle_list)
                
            })
        }
        else if indexPath.row == 16 {
                   SettingVM.shared.getSelectingAges(completion: {_ in
                   
                           let age_list = SettingVM.AgeList
                   
                           self.showSelectView(items: age_list)
                       
                   })
        }
        else if indexPath.row == 17 {
                   SettingVM.shared.getTallSetting(completion: {_ in
                   
                           let tall_list = SettingVM.TallList
                   
                           self.showSelectView(items: tall_list)
                       
                   })
        }
        else if indexPath.row == 18 {
            SettingVM.shared.getStyleSetting(completion: {_ in
            
                    let style_list = SettingVM.StyleList
            
                    self.showSelectView(items: style_list)
                
            })
            
        }
        
    }
    func showSlectViewWithRadio(items: [String]) {
        
          guard let popupVC = storyboard?.instantiateViewController(withIdentifier: "otherSettingVC") as? otherSettingVC else { return }
                  
                
          popupVC.height = CGFloat((items.count + 1) * AppConstant.height_60)
          popupVC.topCornerRadius = 10
          popupVC.presentDuration = 1
          popupVC.dismissDuration = 1
          popupVC.shouldDismissInteractivelty = true
          popupVC.items = items
          popupVC.delegate = self

          present(popupVC, animated: true, completion: nil)
    }
    func showSelectView(items: [String]) {
        
        guard let popupVC = storyboard?.instantiateViewController(withIdentifier: "BottomeSelectVC") as? BottomeSelectVC else { return }
        
        let height_view = self.view.frame.size.height
        let height_bottom_view = (items.count + 1) * AppConstant.height_60 
        if height_bottom_view > Int(height_view) {
            popupVC.height = CGFloat(height_view - 50)
        }
        else {
            popupVC.height = CGFloat(height_bottom_view + 70)
            
        }
        popupVC.topCornerRadius = 10
        popupVC.presentDuration = 1
        popupVC.dismissDuration = 1
        popupVC.shouldDismissInteractivelty = true
        popupVC.items = items
        popupVC.delegate = self
       
        present(popupVC, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(AppConstant.height_60)
    }
    
    
}
extension mainProfileVC: PopUpDelegate {
    func PopupWillDismissForData(data: String) {
        self.value_profile[self.selected_item] = data
        self.tableView.reloadData()
        print(data)
    }
    

        
}

extension mainProfileVC: SearchTypeDelegate {
    func selectSearchType(index: Int, type: String) {//  here index is unused
        self.value_profile[self.selected_item] = type
        self.tableView.reloadData()
        print(type)
    }
    
  
    

        
}
extension mainProfileVC: BottomPopupDelegate {
  
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
