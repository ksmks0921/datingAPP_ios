//
//  footVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/17/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

class settingVC: UIViewController {

    @IBOutlet weak var contentTableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    
    let items = ["自動ログイン", "画面のロック", "パスワード設定", "通知設定", "ライセンス"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let nib_1 = UINib.init(nibName: "settingCellSwitch", bundle: nil)
        contentTableView.register(nib_1, forCellReuseIdentifier: "settingCellSwitch")
        let nib_2 = UINib.init(nibName: "SettingCell", bundle: nil)
        contentTableView.register(nib_2, forCellReuseIdentifier: "SettingCell")

       
    }
    override func viewDidDisappear(_ animated: Bool) {
    
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
          
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
       
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
    
    @objc func switchAutoLogin(_ sender: UISwitch) {
        if sender.isOn == true {
            DataManager.isAutoLogin = true
          
        }
        else {
            DataManager.isAutoLogin = false
         
        }
        
    }
    @objc func switchScreenLock(_ sender: UISwitch) {
        if sender.isOn == true {
            DataManager.isLockScreen = true
          
        }
        else {
            DataManager.isLockScreen = false
         
        }
    }

}
extension settingVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "settingCellSwitch", for: indexPath as IndexPath) as! settingCellSwitch
            cell.nameLabel.text = items[indexPath.row]
            cell.selectionStyle = .none
            if DataManager.isAutoLogin {
                cell.switchButton.isOn = true
            }
            else {
                cell.switchButton.isOn = false
            }
            cell.switchButton.addTarget(self, action: #selector(switchAutoLogin(_:)), for: .valueChanged)
            return cell
            
        }
        else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "settingCellSwitch", for: indexPath as IndexPath) as! settingCellSwitch
            cell.nameLabel.text = items[indexPath.row]
            cell.selectionStyle = .none
            if DataManager.isLockScreen == true {
                cell.switchButton.isOn = true
            }
            else {
                cell.switchButton.isOn = false
            }
            cell.switchButton.addTarget(self, action: #selector(switchScreenLock(_:)), for: .valueChanged)
            return cell
            
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath as IndexPath) as! SettingCell
            cell.nameLabel.text = items[indexPath.row]
            return cell
            
        }
        

        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(AppConstant.height_50)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if indexPath.row == 2 {
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "passwordChangeVC") as! passwordChangeVC
            navigationController?.pushViewController(VC, animated: true)
        }
        if indexPath.row == 3 {
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "alarmSettingVC") as! alarmSettingVC
            navigationController?.pushViewController(VC, animated: true)
        }
    }
    
}
