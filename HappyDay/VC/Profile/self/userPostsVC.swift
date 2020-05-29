//
//  ignoreListVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/18/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

class userPostsVC: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentTable: UITableView!
    var items = [PostEvent]()
    var titleText: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib.init(nibName: "postTableViewCell", bundle: nil)
        self.contentTable.register(nib, forCellReuseIdentifier: "postTableViewCell")
        
        
        Indicator.sharedInstance.showIndicator()
        UserVM.shared.getMyEventPosts(completion:  {_ in
              Indicator.sharedInstance.hideIndicator()
              self.items = UserVM.my_eventPosts
              self.contentTable.reloadData()
        })
        
        titleLabel.text = titleText
        
    }
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
       
                
    }
    

}
extension userPostsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
            return items.count
       
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = contentTable.dequeueReusableCell(withIdentifier: "postTableViewCell", for: indexPath as IndexPath) as! postTableViewCell
        
        cell.personPhoto.sd_setImage(with: URL(string: items[indexPath.row].user_avatar), placeholderImage: UIImage(named: "avatar_woman"))
        cell.age_region_label.text = "(" + items[indexPath.row].age + " " + items[indexPath.row].region + ")"
        cell.hobbyLabel.text = items[indexPath.row].event_type
        cell.nickname.text = items[indexPath.row].nick_name
        if items[indexPath.row].thumb_path != nil {
           
                cell.postImageView.sd_setImage(with: URL(string: items[indexPath.row].thumb_path), placeholderImage: UIImage(named: "default"))
           
        }
        else {
            
                cell.postImageView.image = UIImage(named: "default")
           
        }
        if items[indexPath.row].gender == true {
            cell.nickname.textColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
           
        }
        else {
            cell.nickname.textColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        }
        cell.textContentLabel.text = items[indexPath.row].event_des
        cell.views.text = items[indexPath.row].view_counts
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(AppConstant.height_postTableCell)
       
    }
    
    
}
