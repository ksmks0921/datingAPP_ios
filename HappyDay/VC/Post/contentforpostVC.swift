//
//  contentforpostVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/15/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit
import JXSegmentedView

class contentforpostVC: BaseVC {

   
    @IBOutlet weak var altertview: UIView!
    
    @IBOutlet weak var noResultView: UIView!
    @IBOutlet weak var hegiht_tableView: NSLayoutConstraint!
    @IBOutlet weak var postTableView: UITableView!
    var pageType:Int?
    var event_post = [PostEvent]()
    var height_table : Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = default_green_color
        UINavigationBar.appearance().tintColor = UIColor.white
        self.title = "掲示板"
        
        let nib = UINib.init(nibName: "postTableViewCell", bundle: nil)
        self.postTableView.register(nib, forCellReuseIdentifier: "postTableViewCell")

        if DataManager.isShowingFilterResult! {
            self.event_post = UserVM.filtered_eventPosts
            if self.event_post.count == 0 {
                self.noResultView.alpha = 1
            }
            else {
                self.noResultView.alpha = 0
            }
            self.postTableView.reloadData()
            hegiht_tableView.constant = CGFloat(height_table)
        }
        else {
            hegiht_tableView.constant = CGFloat(height_table)
            getData()
        }
        
       
    }
  
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    func getData() {
        Indicator.sharedInstance.showIndicator()
        UserVM.shared.getEventPosts(completion:  {_ in
              Indicator.sharedInstance.hideIndicator()
              self.event_post = UserVM.eventPosts
                    if self.event_post.count == 0 {
                        self.noResultView.alpha = 1
                    }
                    else {
                        self.noResultView.alpha = 0
                    }
//              self.hegiht_tableView.constant = CGFloat(self.height_table - 50)
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
                cell.postImageView.sd_setImage(with: URL(string: event_post[indexPath.row].thumb_path), placeholderImage: UIImage(named: "default"))
            }
            else {
                cell.postImageView.image = UIImage(named: "default")
            }
            if event_post[indexPath.row].gender == true {
                cell.nickname.textColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
               
            }
            else {
                cell.nickname.textColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
            }
            cell.textContentLabel.text = event_post[indexPath.row].event_des
            cell.views.text = event_post[indexPath.row].view_counts
            cell.regionLabel.text = event_post[indexPath.row].region
            cell.timeLabel.text = event_post[indexPath.row].created_at
            cell.selectionStyle = .none
            return cell
           
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(AppConstant.height_postTableCell)
       
    }
    
}
