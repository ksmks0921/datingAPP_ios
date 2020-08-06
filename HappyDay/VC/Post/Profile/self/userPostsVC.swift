//
//  ignoreListVC.swift
//  HappyDay
//
//  Created by Panda Star on 1/18/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit
import ANZSingleImageViewer
import AVKit
import AVFoundation

class userPostsVC: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentTable: UITableView!
    var items = [PostEvent]()
    var titleText: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentTable.backgroundColor = UIColor.white
        let nib = UINib.init(nibName: "postTableViewCell", bundle: nil)
        self.contentTable.register(nib, forCellReuseIdentifier: "postTableViewCell")
        
        
        Indicator.sharedInstance.showIndicator()
        UserVM.shared.getMyEventPosts(completion:  {_ in
              Indicator.sharedInstance.hideIndicator()
              let event_post_temp = UserVM.my_eventPosts
              self.items = event_post_temp.sorted(by: {$0.created_at > $1.created_at})
      
              self.contentTable.reloadData()
        })
        
        titleLabel.text = titleText
        
    }
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
    @objc func imageTapped(_ gesture:UITapGestureRecognizer) {
        print("_____tag\(gesture.view!.tag)")
        print("_____type\(items[gesture.view!.tag].source_type)")
        let tag =  gesture.view!.tag
        if items[tag].source_type == "video" {

            let videoUrl: URL = URL(string: items[tag].event_photo)!
            let player = AVPlayer(url: videoUrl)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            self.present(playerViewController, animated: true) {
                playerViewController.player!.play()
            }
            UserVM.shared.addView(event: items[tag]) { (success, message, error) in
                print("viewed!!!")
            }

        }
        else {
            let image_url : URL = URL(string: items[tag].event_photo)!
            let imageData = try! Data(contentsOf: image_url)

            let image = UIImage(data: imageData)
            ANZSingleImageViewer.showImage(image!, toParent: self)
            
        }
      // open your camera controller here
    }

}
extension userPostsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
            return items.count
       
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = contentTable.dequeueReusableCell(withIdentifier: "postTableViewCell", for: indexPath as IndexPath) as! postTableViewCell
        
  
        let avatar = UserVM.current_user.user_avatar![0]
        cell.personPhoto.sd_setImage(with: URL(string: avatar))
        
        cell.age_region_label.text = "(" + items[indexPath.row].age + " " + items[indexPath.row].region + ")"
        cell.hobbyLabel.text = items[indexPath.row].event_type
        cell.nickname.text = items[indexPath.row].nick_name
        cell.regionLabel.text = items[indexPath.row].region
        cell.timeLabel.text = items[indexPath.row].created_date
        if items[indexPath.row].thumb_path != nil {
           
                cell.postImageView.sd_setImage(with: URL(string: items[indexPath.row].thumb_path), placeholderImage: UIImage(named: "default"))
           
        }
        else {
            
                cell.postImageView.image = UIImage(named: "default")
           
        }
        if items[indexPath.row].source_type == "image" {
            cell.postImageView.sd_setImage(with: URL(string: items[indexPath.row].event_photo), placeholderImage: UIImage(named: "default"))
            cell.playButton.isHidden = true
        }
        else {
            cell.postImageView.sd_setImage(with: URL(string: items[indexPath.row].thumb_path), placeholderImage: UIImage(named: "default"))
            cell.playButton.isHidden = false
        }
        if items[indexPath.row].gender == true {
            cell.nickname.textColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
           
        }
        else {
            cell.nickname.textColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        }
        
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
        cell.postImageView.tag = indexPath.row
        cell.postImageView.isUserInteractionEnabled = true
        cell.postImageView.addGestureRecognizer(imageTap)
        
        cell.textContentLabel.text = items[indexPath.row].event_des
        cell.views.text = items[indexPath.row].view_counts
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(AppConstant.height_postTableCell)
       
    }
    
    
}
