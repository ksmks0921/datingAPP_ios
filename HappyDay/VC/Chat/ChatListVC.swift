//
//  chatListVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/16/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

class chatListVC: UIViewController {


    @IBOutlet weak var chatListTableView: UITableView!
    
   
    var lists = [ChatListItem]()
    override func viewDidLoad() {
        super.viewDidLoad()
        

         let nib = UINib.init(nibName: "chatTableCell", bundle: nil)
         self.chatListTableView.register(nib, forCellReuseIdentifier: "chatTableCell")
         chatListTableView.reloadData()
        MessageVM.shared.geAllData(sender_id: UserVM.current_user.user_id!, completion: {_ in
            MessageVM.shared.getChatListContents(completion: {_ in
                       self.lists = MessageVM.shared.chatListItems
                       self.chatListTableView.reloadData()
            })
        })
         
       

        navigationItem.backBarButtonItem = UIBarButtonItem(
        title: "Something Else", style: .plain, target: nil, action: nil)

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Something Else"
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
    }
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           navigationController?.setNavigationBarHidden(true, animated: animated)
    }
   

}

extension chatListVC:  UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
            return lists.count
       
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         
             return CGSize(width: self.chatListTableView.frame.size.width, height: 100)
        

     }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = chatListTableView.dequeueReusableCell(withIdentifier: "chatTableCell", for: indexPath as IndexPath) as! chatTableCell
        cell.photo.sd_setImage(with: URL(string: lists[indexPath.row].avatar), placeholderImage: UIImage(named: "avatar_woman"))
        cell.name.text = lists[indexPath.row].nick_name
        let age_region: String!
        age_region = lists[indexPath.row].age + " " + lists[indexPath.row].region
        cell.age_region_label.text = age_region
        cell.last_chat_label.text = lists[indexPath.row].last_message
        let time_date: String!
        time_date = lists[indexPath.row].last_connect_time + " " + lists[indexPath.row].last_connect_date
        cell.time_label.text = time_date
        return cell
           
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 90
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            let connect_user = MessageVM.shared.getDataFromUsers(id: lists[indexPath.row].id!)
//            let privateChatView = MKPrivateChatView()
        guard let privateChatView = storyboard?.instantiateViewController(withIdentifier: "MKPrivateChatView") as? MKPrivateChatView else { return }
            privateChatView.chatId = UserVM.current_user.user_id!
            privateChatView.connectedPerson = connect_user
            privateChatView.chat_title = connect_user.user_nickName
            let backItem = UIBarButtonItem()
            backItem.title = "뒤로"
            backItem.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
            self.navigationController?.pushViewController(privateChatView, animated: true)
        

    
    }
    
}
