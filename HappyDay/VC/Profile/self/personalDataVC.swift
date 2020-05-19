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
    var user: person!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if UserVM.current_user != nil {
            user = UserVM.current_user
            dataContentView.text = user.user_introduce
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           
           navigationController?.setNavigationBarHidden(true, animated: animated)
          
                   
    }
    @IBAction func sendBtnTapped(_ sender: Any) {
        
        let sex = { () -> Bool in
            if self.user.user_sex == "남자" {
                return true
            }
            else {
                return false
            }
        }
        UserVM.shared.updateUserData(city: user.user_city!, age: user.user_age!, job: user.user_job!, blood: user.user_blood!, star: user.user_star!, tall: user.user_tall!, user_style: user.user_style!, life_style: user.user_lifestyle!, user_outside: user.user_outside!, sex: sex(), nick_name: user.user_nickName!, style_1: user.style_1!, style_2: user.style_2!, style_3: user.style_3!, style_4: user.style_4!, require_age: user.required_age!, is_approved: user.is_approved!, updated_at: user.updated_at!, created_at: user!.created_at!, require_style: user.require_style!, require_tall: user.require_tall!, status: user!.user_status!, introduce: self.dataContentView.text, date: user!.user_date!, user_avatar: user.user_avatar!) {(success, message, error) in
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
    
    @IBAction func backBtnTapped(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
}
