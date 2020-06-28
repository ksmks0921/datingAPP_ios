//
//  contentforpostVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/15/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit
import JXSegmentedView
import Lightbox

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
    @objc func imageTapped(_ gesture:UITapGestureRecognizer) {
        let tag =  gesture.view!.tag
        if event_post[tag].source_type == "video" {
            let url = URL(string:event_post[tag].thumb_path)
               if let data = try? Data(contentsOf: url!)
               {
                let video_url : String = event_post[tag].event_photo
                let image: UIImage = UIImage(data: data)!
                    let video = [LightboxImage(
                      image: image,
                      text: "",
                      videoURL: URL(string: video_url)
                    )]
                    let controller = LightboxController(images: video)
                    controller.pageDelegate = self
                    controller.dismissalDelegate = self
                    controller.dynamicBackground = true
                    LightboxConfig.CloseButton.image = UIImage(named: "icon_close1")
                    LightboxConfig.CloseButton.text = ""
                    present(controller, animated: true, completion: nil)
               }
            
        }
        else {
            let images = [LightboxImage(imageURL: URL(string: event_post[tag].event_photo)!)]
            let controller = LightboxController(images: images)
            controller.pageDelegate = self
            controller.dismissalDelegate = self
            controller.dynamicBackground = true
            LightboxConfig.CloseButton.image = UIImage(named: "icon_close1")
            LightboxConfig.CloseButton.text = ""
            present(controller, animated: true, completion: nil)
        }
      // open your camera controller here
    }
    

}



extension contentforpostVC: JXSegmentedListContainerViewListDelegate{
    
    func listView() -> UIView {
        return view
    }
}
extension contentforpostVC:  UITableViewDelegate, UITableViewDataSource, LightboxControllerPageDelegate ,LightboxControllerDismissalDelegate  {
    func lightboxController(_ controller: LightboxController, didMoveToPage page: Int) {
        print("ok")
    }
    
    func lightboxControllerWillDismiss(_ controller: LightboxController) {
        print("ok")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return event_post.count
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = postTableView.dequeueReusableCell(withIdentifier: "postTableViewCell", for: indexPath as IndexPath) as! postTableViewCell
        
            cell.personPhoto.sd_setImage(with: URL(string: event_post[indexPath.row].user_avatar), placeholderImage: UIImage(named: "avatar_woman"))
            cell.age_region_label.text = "(" + event_post[indexPath.row].age + " " + event_post[indexPath.row].region + ")"
            cell.hobbyLabel.text = event_post[indexPath.row].event_type
            cell.nickname.text = event_post[indexPath.row].nick_name
        
            if event_post[indexPath.row].source_type == "image" {
                cell.postImageView.sd_setImage(with: URL(string: event_post[indexPath.row].event_photo), placeholderImage: UIImage(named: "default"))
                cell.playButton.isHidden = true
            }
            else {
                cell.postImageView.sd_setImage(with: URL(string: event_post[indexPath.row].thumb_path), placeholderImage: UIImage(named: "default"))
                cell.playButton.isHidden = false
            }
        
            
            if event_post[indexPath.row].gender == true {
                cell.nickname.textColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
               
            }
            else {
                cell.nickname.textColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
            }
            let imageTap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
            cell.postImageView.tag = indexPath.row
            cell.postImageView.isUserInteractionEnabled = true
            cell.postImageView.addGestureRecognizer(imageTap)
        
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
