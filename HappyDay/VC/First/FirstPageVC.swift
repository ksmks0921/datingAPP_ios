//
//  FirstPageVC.swift
//  HappyDay
//
//  Created by 李炅 on 2020/8/3.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class FirstPageVC: BaseVC {

    @IBOutlet weak var alertView: UIImageView!
    @IBOutlet weak var alertViewCloseBtn: UIButton!
    var player : AVPlayer!
    var avAssets : AVAsset!
    @IBOutlet weak var videoView: UIView!
   
    @IBOutlet weak var bottomLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        alertView.isHidden = true
        alertViewCloseBtn.isHidden = true
        showVideo()
       
        if DataManager.isAutoLogin == nil {
            DataManager.isAutoLogin = false
        }
        if DataManager.messageAlarm == nil {
            DataManager.messageAlarm = false
        }
        if DataManager.likeAlarm == nil {
            DataManager.likeAlarm = false
        }
        if DataManager.reportAlarm == nil {
            DataManager.reportAlarm = false
        }
        if DataManager.isLockScreen == nil {
            DataManager.isLockScreen = false
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(FirstPageVC.tapFunction))
        bottomLabel.isUserInteractionEnabled = true
        bottomLabel.addGestureRecognizer(tap)
    }
   @objc
   func tapFunction(sender:UITapGestureRecognizer) {
       print("tap working")
   }
    override func viewWillAppear(_ animated: Bool) {
         
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
       
       
    }
   
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
   
    override func viewDidLayoutSubviews() {
       
    }
    @IBAction func alertCloseBtnTapped(_ sender: Any) {
        alertView.isHidden = true
        alertViewCloseBtn.isHidden = true
       
    }
    @IBAction func gotoLogin(_ sender: Any) {
        if DataManager.isAutoLogin {
                      Indicator.sharedInstance.showIndicator()
            UserVM.shared.login(email: DataManager.email!, password: DataManager.password!) { (success, message, error) in
                                 if error == nil{
                                     if success{
                                          Indicator.sharedInstance.hideIndicator()
                                          DataManager.isLogin = true
                                          DataManager.isShowingSearchResult = false
                                     
                                          SettingVM.shared.getPoints()
                                          SettingVM.shared.getLikes()
                                          SettingVM.shared.getMemos()
                                          SettingVM.shared.getIgnores()
                                          SettingVM.shared.getBlocks()
                                          let VC = self.storyboard?.instantiateViewController(withIdentifier: "customTabBarVC") as! customTabBarVC
                                          self.navigationController?.pushViewController(VC, animated: true)
                                         
                                     
                                     
                                      } else {
                                          self.showAlert(message: message)
                                      }
                                 
                              }else {
                                  self.showAlert(message: message)
                              }
                      }
        }
        else {
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "loginVC") as! loginVC
            navigationController?.pushViewController(VC, animated: true)
        }
       
       
               
    }
    @IBAction func gotoSignUp(_ sender: Any) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "signUpVC") as! signUpVC
        navigationController?.pushViewController(VC, animated: true)
    }
    @IBAction func facebookLogin(_ sender: Any) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "facebookLoginVC") as! facebookLoginVC
        navigationController?.pushViewController(VC, animated: true)
    }
    private func showVideo(){
           let videoURL = Bundle.main.url(forResource: "splash", withExtension: "mp4") // Get video url
        if videoURL != nil {
            player = AVPlayer(url: videoURL!)
            avAssets = AVAsset(url: videoURL!)
            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = self.videoView.bounds
            playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            self.videoView.layer.addSublayer(playerLayer)
             player.play()
             player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1) , queue: .main) { [weak self] time in
                 
                 if time == self!.avAssets.duration {
                     
                     
                 }
                 
             }
            NotificationCenter.default.addObserver(self,selector: #selector(itemDidReachEnd),
                                                   name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
            object: player.currentItem)
        }
           
       
    }
    @objc func itemDidReachEnd(notification: NSNotification) {
        player.seek(to: CMTime.zero)
        player.play()
    }

}
