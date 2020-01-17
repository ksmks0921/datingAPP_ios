//
//  chatListVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/16/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit
import JXSegmentedView
class chatListVC: UIViewController {

   
    var partners = [person]()
    @IBOutlet weak var chatListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//           view.backgroundColor = UIColor(red: CGFloat(arc4random()%255)/255, green: CGFloat(arc4random()%255)/255, blue: CGFloat(arc4random()%255)/255, alpha: 1)
         let nib = UINib.init(nibName: "chatTableCell", bundle: nil)
         self.chatListTableView.register(nib, forCellReuseIdentifier: "chatTableCell")
         chatListTableView.reloadData()
        
          
        for _ in 1...5 {
              let partner = person()
              partner?.name = "zhang xiao ling"
              partners.append(partner!)
              
        }

        
    }
    

   

}

extension chatListVC: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}
extension chatListVC:  UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
            return partners.count
       
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
            let cell = chatListTableView.dequeueReusableCell(withIdentifier: "chatTableCell", for: indexPath as IndexPath) as! chatTableCell
            cell.photo.image = UIImage(named: "second")
           

            return cell
           
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "chatRoomVC") as! chatRoomVC
        navigationController?.pushViewController(VC, animated: true)
    }
}
