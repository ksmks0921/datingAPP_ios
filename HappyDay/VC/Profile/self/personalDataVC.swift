//
//  personalDataVC.swift
//  HappyDay
//
//  Created by Crystal Abarientos on 5/18/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

class personalDataVC: BaseVC {

    @IBOutlet weak var dataContentView: UITextView!
    
    @IBOutlet weak var titleLabel: UILabel!
    var user: person!
    var report_person : person!
    var from = "personal"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if UserVM.current_user != nil {
            user = UserVM.current_user
            
            if from == "report" {
               
                titleLabel.text = "通報:" + String(report_person.user_nickName!)
                dataContentView.customplaceholder = "通報内容を入力してください。"
            }
            else {
                titleLabel.text = "自己紹介"
                dataContentView.text = user.user_introduce
            }
            
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           
           navigationController?.setNavigationBarHidden(true, animated: animated)
          
                   
    }
    
    @IBAction func sendBtnTapped(_ sender: Any) {
        if from == "personal" {
            let sex = { () -> Bool in
                if self.user.user_sex == "男性" {
                    return true
                }
                else {
                    return false
                }
            }
            Indicator.sharedInstance.showIndicator()
            UserVM.shared.updateUserData(city: user.user_city!, age: user.user_age!, job: user.user_job!, blood: user.user_blood!, star: user.user_star!, tall: user.user_tall!, user_style: user.user_style!, life_style: user.user_lifestyle!, user_outside: user.user_outside!, sex: sex(), nick_name: user.user_nickName!, style_1: user.style_1!, style_2: user.style_2!, style_3: user.style_3!, style_4: user.style_4!, require_age: user.required_age!, is_approved: user.is_approved!, updated_at: user.updated_at!, created_at: user!.created_at!, require_style: user.require_style!, require_tall: user.require_tall!, status: user!.user_status!, introduce: self.dataContentView.text, date: user!.user_date!, user_avatar: user.user_avatar!) {(success, message, error) in
                Indicator.sharedInstance.hideIndicator()
                if error == nil {
                    if success {
                        self.showAlert(message: "成功!")
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
        else {
            let report_avatar = report_person.user_avatar
            let user_avatar = user.user_avatar
            Indicator.sharedInstance.showIndicator()
            UserVM.shared.reportSomeone(reason: self.dataContentView.text, receiver_id: report_person.user_id!, receiver_image: report_avatar![0], receiver_name: report_person.user_nickName!, sender_id: user.user_id!, sender_image: user_avatar![0], sender_name: user.user_nickName!) {_ in
                Indicator.sharedInstance.hideIndicator()
                self.showAlert(message: "成功!")
                
            }
            
            
            
        }
        
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
}
