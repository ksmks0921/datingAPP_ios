//
//  contentforpostVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/15/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit
import JXSegmentedView

class contentforpostVC: UIViewController {

   
    @IBOutlet weak var altertview: UIView!
    
    @IBOutlet weak var postTableView: UITableView!
    var pageType:Int?
    var event_post = [PostEvent]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2039215686, green: 0.7803921569, blue: 0.3490196078, alpha: 1)
        UINavigationBar.appearance().tintColor = UIColor.white
        self.title = "게시판"
        
        let nib = UINib.init(nibName: "postTableViewCell", bundle: nil)
        self.postTableView.register(nib, forCellReuseIdentifier: "postTableViewCell")
        if DataManager.isShowingFilterResult! {
            self.event_post = UserVM.filtered_eventPosts
            self.postTableView.reloadData()
        }
        else {
            getData()
        }
        
       
    }
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func getData() {
        Indicator.sharedInstance.showIndicator()
        UserVM.shared.getEventPosts(completion:  {_ in
              Indicator.sharedInstance.hideIndicator()
              self.event_post = UserVM.eventPosts
              self.postTableView.reloadData()
        })
    }

    

}



extension contentforpostVC: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}
extension contentforpostVC:  UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return event_post.count
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = postTableView.dequeueReusableCell(withIdentifier: "postTableViewCell", for: indexPath as IndexPath) as! postTableViewCell
        
            cell.personPhoto.sd_setImage(with: URL(string: event_post[indexPath.row].user_avatar), placeholderImage: UIImage(named: "avatar_woman"))
            cell.age_region_label.text = "(" + event_post[indexPath.row].age + " " + event_post[indexPath.row].region + ")"
            cell.hobbyLabel.text = event_post[indexPath.row].event_type
            cell.nickname.text = event_post[indexPath.row].nick_name
            if event_post[indexPath.row].thumb_path != nil {
                cell.postImageView.sd_setImage(with: URL(string: event_post[indexPath.row].thumb_path), placeholderImage: UIImage(systemName: "photo"))
            }
            else {
                cell.postImageView.image = UIImage(systemName: "photo")
            }
            if event_post[indexPath.row].gender == true {
                cell.nickname.textColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
               
            }
            else {
                cell.nickname.textColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
            }
            cell.textContentLabel.text = event_post[indexPath.row].event_des
            cell.views.text = event_post[indexPath.row].view_counts
            return cell
           
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 300
       
    }
    
}
