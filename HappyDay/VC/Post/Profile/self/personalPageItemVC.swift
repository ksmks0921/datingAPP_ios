//
//  noSeeVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/18/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

class personalPageItemVC: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var contentTable: UITableView!
    
    var items = [Like]()
    var titleText: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        contentTable.backgroundColor = UIColor.white
        let nib = UINib.init(nibName: "chatTableCell", bundle: nil)
        self.contentTable.register(nib, forCellReuseIdentifier: "chatTableCell")
        
       
        alertLabel.text = String(items.count) + "人"
        titleLabel.text = titleText
        
        
       
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
    
    @objc func imageTapped(_ gesture : UITapGestureRecognizer) {
        let v = gesture.view!
        let tag = v.tag
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "profileVC") as! profileVC
        let selected_person = getDataFromUsers(id: items[tag].like_id)
        VC.person = selected_person

        navigationController?.pushViewController(VC, animated: true)
        
    }
    func getDataFromUsers(id: String) -> person{
           var target_user: person!
           for user_item in UserVM.all_users {
               
               if user_item.user_id == id {
                   
                  target_user = user_item
                   
               }
               
           }
           
           return target_user
    }
}
extension personalPageItemVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
            return items.count
       
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = contentTable.dequeueReusableCell(withIdentifier: "chatTableCell", for: indexPath as IndexPath) as! chatTableCell
       
        cell.photo.sd_setImage(with: URL(string: items[indexPath.row].like_avatar), placeholderImage: UIImage(named: "avatar_woman"))
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
        cell.photo.tag = indexPath.row
        cell.photo.isUserInteractionEnabled = true
        cell.photo.addGestureRecognizer(singleTap)
        
        
        cell.name.text = items[indexPath.row].like_name
       
        cell.age_region_label.text = items[indexPath.row].like_age
        cell.last_chat_label.text = items[indexPath.row].like_city
        cell.statusView.isHidden = true
        
        
        let time_text = items[indexPath.row].like_date
        
        cell.time_label.text = items[indexPath.row].like_date
       
        if items[indexPath.row].user_sex == true {
            cell.name.textColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
           
        }
        else {
            cell.name.textColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let connect_user = MessageVM.shared.getDataFromUsers(id: items[indexPath.row].like_date!)

        guard let privateChatView = storyboard?.instantiateViewController(withIdentifier: "MKPrivateChatView") as? MKPrivateChatView else { return }
        privateChatView.chatId = UserVM.current_user.user_id!
        privateChatView.connectedPerson = connect_user
        privateChatView.chat_title = connect_user.user_nickName
        let backItem = UIBarButtonItem()
        backItem.title = ""
        backItem.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
        self.navigationController?.pushViewController(privateChatView, animated: true)
    }
    
}
