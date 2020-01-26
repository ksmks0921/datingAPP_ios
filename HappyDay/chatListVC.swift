//
//  chatListVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/16/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

class chatListVC: UIViewController {

   
    var partners = [message]()
    @IBOutlet weak var chatListTableView: UITableView!
    
//    var persons =
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

         let nib = UINib.init(nibName: "chatTableCell", bundle: nil)
         self.chatListTableView.register(nib, forCellReuseIdentifier: "chatTableCell")
         chatListTableView.reloadData()
        
        
        let person_1 = message(name: "장소영", photo: "person_1", last_message: "뭐하니?", is_favorite: true, has_new: true)
        partners.append(person_1)
        let person_2 = message(name: "하춘", photo: "person_2", last_message: "잘지내니?", is_favorite: true, has_new: false)
        partners.append(person_2)
        let person_3 = message(name: "소영영", photo: "person_3", last_message: "안녕?.", is_favorite: false, has_new: false)
        partners.append(person_3)
        let person_4 = message(name: "하의의", photo: "person_4", last_message: "그렇게 하자.", is_favorite: false, has_new: true)
        partners.append(person_4)
        

    }
    

   

}

extension chatListVC:  UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
            return partners.count
       
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
            let cell = chatListTableView.dequeueReusableCell(withIdentifier: "chatTableCell", for: indexPath as IndexPath) as! chatTableCell
            let item = partners[indexPath.row]
            
            cell.name.text = item.name
            cell.message.text = item.last_message
            cell.photo.image = UIImage(named: item.photo ?? "avatar_woman" )
            if item.is_favorite == true {
                cell.contentView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            }
            else {
                cell.contentView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
            if item.has_new == true {
                cell.newBadge.isHidden = false
            }
            else {
                cell.newBadge.isHidden = true
            }
          
            return cell
           
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(AdvancedExampleViewController(), animated: true)
//        print("sdfsdf")
    }
}
