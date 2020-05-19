//
//  favoriteListVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/18/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

class alarmSettingVC: UIViewController {
    
    @IBOutlet weak var contentTableView: UITableView!
    var items = ["메쎄지 알림", "라이크 알림", "공지사항 알림"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib.init(nibName: "settingCellSwitch", bundle: nil)
        contentTableView.register(nib, forCellReuseIdentifier: "settingCellSwitch")
      
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
       
                
    }
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func messageAlarmValueDidChange(_ sender: UISwitch) {
        if sender.isOn == true {
            DataManager.messageAlarm = true
          
        }
        else {
            DataManager.messageAlarm = false
         
        }
        
    }
    @objc func likeAlarmValueDidChange(_ sender: UISwitch) {
        if sender.isOn == true {
            DataManager.likeAlarm = true
          
        }
        else {
            DataManager.likeAlarm = false
         
        }
        
    }
    @objc func reportValueDidChange(_ sender: UISwitch) {
        if sender.isOn == true {
            DataManager.reportAlarm = true
          
        }
        else {
            DataManager.reportAlarm = false
         
        }
        
    }

}
extension alarmSettingVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "settingCellSwitch", for: indexPath as IndexPath) as! settingCellSwitch
            cell.nameLabel.text = items[indexPath.row]
            cell.selectionStyle = .none
        if indexPath.row == 0 {
            if DataManager.messageAlarm == true {
                cell.switchButton.isOn = true
            }
            else {
                cell.switchButton.isOn = false
            }
            cell.switchButton.addTarget(self, action: #selector(messageAlarmValueDidChange(_:)), for: .valueChanged)
        }
        else if indexPath.row == 1 {
            if DataManager.likeAlarm == true {
                cell.switchButton.isOn = true
            }
            else {
                cell.switchButton.isOn = false
            }
            cell.switchButton.addTarget(self, action: #selector(likeAlarmValueDidChange(_:)), for: .valueChanged)
        }
        else {
            if DataManager.reportAlarm == true {
                cell.switchButton.isOn = true
            }
            else {
                cell.switchButton.isOn = false
            }
            cell.switchButton.addTarget(self, action: #selector(reportValueDidChange(_:)), for: .valueChanged)
        }
            return cell

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(AppConstant.height_50)
    }
}